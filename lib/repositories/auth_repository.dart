import 'package:jantari/models/login/login.dart';
import 'package:jantari/network_services/network_service.dart';

class Repository {
  final NetworkService? networkService;

  Repository({this.networkService});

  Future<Authentication> authenticate(String username, String password) async {
    // print("authenticate clicked in repository");
    final authenticateObj = {
      "grantType": "password",
      "clientId": "cjGhup1fkP1JPvQUaPddR8vqPGcfJQCP",
      "clientSecret": "dKtkAV6nZZmLhFkdYXBRrBxqpI8lOX0O",
      "provisionKey": "unikrew",
      "username": username,
      "password": password
    };

    final authenticate = await networkService?.authenticate(authenticateObj);

    return Authentication.fromJson(authenticate);
  }
}
