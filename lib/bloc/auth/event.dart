part of 'bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GenerateTokenFromClientCredentials extends AuthEvent {
  const GenerateTokenFromClientCredentials();

  List<Object> get props => [];
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted(this.username, this.password);

  final String username;
  final String password;

  List<Object> get props => [username, password];
}

class FetchUser extends AuthEvent {
  const FetchUser(
      this.userCode,
      );

  final String userCode;

  List<Object> get props => [userCode];
}

class FetchGroupDetail extends AuthEvent {
  const FetchGroupDetail(
      this.groupCodes,
      );

  final List<String> groupCodes;

  List<Object> get props => [groupCodes];
}

class ResetAllLoginState extends AuthEvent {
  const ResetAllLoginState();
}
