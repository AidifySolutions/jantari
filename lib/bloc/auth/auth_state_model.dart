import 'package:jantari/models/auth.dart';
import 'package:equatable/equatable.dart';

class AuthStateModel extends Equatable {
  const AuthStateModel({
    this.loginResponse,
    this.userDetail,
    this.permissionDictionary,
    this.errorMessage,
  });

  final Login? loginResponse;
  final User? userDetail;
  final String? errorMessage;
  final Map<String, List>? permissionDictionary;

  AuthStateModel copyWith({
    Login? loginResponse,
    User? userDetail,
    String? errorMessage,
    Map<String, List>? permissionDictionary,
  }) {
    return AuthStateModel(
      loginResponse: loginResponse ?? this.loginResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      userDetail: userDetail ?? this.userDetail,
      permissionDictionary: permissionDictionary ?? this.permissionDictionary,
    );
  }

  @override
  List<Object?> get props => [loginResponse, errorMessage, userDetail, permissionDictionary];
}
