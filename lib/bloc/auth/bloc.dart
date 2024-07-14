import 'package:bloc/bloc.dart';
import 'package:jantari/bloc/auth/auth_state_model.dart';
import 'package:equatable/equatable.dart';
import 'package:jantari/utils/secure_storage.dart';
import 'package:jantari/utils/helper.dart';

// Repositories
import 'package:jantari/repositories/authentication.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginStateInitial()) {
    on<GenerateTokenFromClientCredentials>(_onGettingClientCredentials);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<FetchUser>(_onFetchingUser);
    on<FetchGroupDetail>(_onFetchingGroupsDetail);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onGettingClientCredentials(
      GenerateTokenFromClientCredentials event,
      Emitter<AuthState> emit,
      ) async {

    try {
      final authenticationResponse = await _authenticationRepository.clientCredentials();

      SecureStorage.setAccessToken(authenticationResponse.accessToken);

      emit(
        ClientCredentialsLoaded(
          authStateModel: state.authStateModel.copyWith(
            loginResponse: authenticationResponse,
          ),
        ),
      );
    } catch (e) {
      print("error in getting client credentials: ${e.toString()}");
    }
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      LoginStateLoading( authStateModel: state.authStateModel),
    );

    try {
      final authenticationResponse = await _authenticationRepository.logIn(
        username: event.username,
        password: event.password,
      );
      SecureStorage.setAccessToken(authenticationResponse.accessToken);

      emit(
        LoginStateLoaded(
          authStateModel: state.authStateModel.copyWith(
            loginResponse: authenticationResponse,
          ),
        ),
      );
    } catch (e) {
      emit(
        LoginStateFailed(
          authStateModel: state.authStateModel.copyWith(
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onFetchingUser(
      FetchUser event,
      Emitter<AuthState> emit,
      ) async {
    emit(
      userStateLoading( authStateModel: state.authStateModel),
    );

    try {
      final response = await _authenticationRepository.getUserDetail(
        userCode: event.userCode
      );

      emit(
        userStateLoaded(
          authStateModel: state.authStateModel.copyWith(
            userDetail: response
          ),
        ),
      );
    } catch (e) {
      emit(
        userStateFailed(
          authStateModel: state.authStateModel.copyWith(
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onFetchingGroupsDetail(
      FetchGroupDetail event,
      Emitter<AuthState> emit,
      ) async {
    emit(
      groupStateLoading( authStateModel: state.authStateModel),
    );

    try {
      final response = await _authenticationRepository.getGroupDetails(
          groupCodes: event.groupCodes
      );

      final permissionDictionary = Helper.getDictionaryForHeader(groups: response);

      emit(
        groupStateLoaded(
          authStateModel: state.authStateModel.copyWith(
              permissionDictionary: permissionDictionary
          ),
        ),
      );
    } catch (e) {
      emit(
        groupStateFailed(
          authStateModel: state.authStateModel.copyWith(
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}
