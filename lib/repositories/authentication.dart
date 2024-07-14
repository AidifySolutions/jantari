import 'dart:async';
import 'dart:convert';
import 'package:jantari/network_services/api_path.dart';
import 'package:jantari/network_services/http_client.dart';
import 'package:jantari/utils/static_data.dart';

// Models
import 'package:jantari/models/auth.dart';

class AuthenticationRepository {
  final HttpClient? httpClient;

  AuthenticationRepository({this.httpClient});

  Future clientCredentials() async {

    final authenticateObj = {
      "grant_type": "client_credentials",
      "client_id": StaticData.clientId,
      "client_secret": StaticData.clientSecret,
      "scope": StaticData.scope
    };

    final response = await HttpClient.instance.postData("https://login.microsoftonline.com/${StaticData.tenantID}/oauth2/v2.0/token",
        authenticateObj, null, excludeBaseURL: true, headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'accept': 'application/x-www-form-urlencoded',
        });

    Login parsedResponse = Login.fromJson(response);

    return parsedResponse;
  }

  Future logIn({
    required String username,
    required String password,
  }) async {

    final authenticateObj = {
      "grantType": "password",
      "clientId": "cjGhup1fkP1JPvQUaPddR8vqPGcfJQCP",
      "clientSecret": "dKtkAV6nZZmLhFkdYXBRrBxqpI8lOX0O",
      "tenantID": "98a89719-0183-4f52-a83d-c1ce236e1a88",
      "provisionKey": "9KRkv8hDB4rpWvsgxTFnPRcfytROPTvv",
      "userName": username,
      "password": password
    };

    final response = await HttpClient.instance.postData(
        ApiPathHelper.getValue(APIPath.authenticate),
        json.encode(authenticateObj), null);

    Login parsedResponse = Login.fromJson(response);

    return parsedResponse;
  }

  Future getUserDetail({
    required String userCode,
  }) async {

    final response = await HttpClient.instance.fetchData(
        '${ApiPathHelper.getValue(APIPath.userDetail)}/$userCode',
        null);

    User parsedResponse = User.fromJson(response);

    return parsedResponse;
  }

  Future getGroupDetails({
    required List groupCodes,
  }) async {

    String queryString = '?isDetailRequired=true';
    for (String groupCode in groupCodes) {
      queryString += '&groupCodes=$groupCode';
    }

    final response = await HttpClient.instance.fetchData(
        ApiPathHelper.getValue(APIPath.groupDetail),
        null, queryString: queryString);

    List<GroupDetail> parsedResponse = response.map<GroupDetail>((e) => GroupDetail.fromJson(e)).toList();

    return parsedResponse;
  }
}
