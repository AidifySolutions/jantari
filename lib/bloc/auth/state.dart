part of 'bloc.dart';

class AuthState extends Equatable {
  final AuthStateModel authStateModel;

  const AuthState({
    required this.authStateModel,
  });

  @override
  List<Object?> get props => [authStateModel];
}

class LoginStateInitial extends AuthState {
  const LoginStateInitial() : super(authStateModel: const AuthStateModel());
}


// getting client credentials
class ClientCredentialsLoaded extends AuthState {
  final AuthStateModel authStateModel;

  const ClientCredentialsLoaded({required this.authStateModel})
      : super(authStateModel: authStateModel);
}


// Login States
class LoginStateLoading extends AuthState {
  final AuthStateModel authStateModel;

  const LoginStateLoading({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

class LoginStateLoaded extends AuthState {
  final AuthStateModel authStateModel;

  const LoginStateLoaded({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

class LoginStateFailed extends AuthState {
  final AuthStateModel authStateModel;

  const LoginStateFailed({required this.authStateModel})
      : super(authStateModel: authStateModel);
}


// User Fetching States
class userStateLoading extends AuthState {
  final AuthStateModel authStateModel;

  const userStateLoading({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

class userStateLoaded extends AuthState {
  final AuthStateModel authStateModel;

  const userStateLoaded({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

class userStateFailed extends AuthState {
  final AuthStateModel authStateModel;

  const userStateFailed({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

// Group Fetching States
class groupStateLoading extends AuthState {
  final AuthStateModel authStateModel;

  const groupStateLoading({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

class groupStateLoaded extends AuthState {
  final AuthStateModel authStateModel;

  const groupStateLoaded({required this.authStateModel})
      : super(authStateModel: authStateModel);
}

class groupStateFailed extends AuthState {
  final AuthStateModel authStateModel;

  const groupStateFailed({required this.authStateModel})
      : super(authStateModel: authStateModel);
}


class ResetAll extends AuthState {
  ResetAll() : super(authStateModel: AuthStateModel());
}
