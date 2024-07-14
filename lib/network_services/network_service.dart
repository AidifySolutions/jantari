import 'dart:convert';

import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "https://services-backend.com/easypaisa_karobar";

  Future<dynamic> authenticate(Map<String, dynamic> authenticateObj) async {
    try {
      final URI = Uri.parse(baseUrl + "/identity/api/v1.0/oauth/token/");

      final response = await post(URI, body: json.encode(authenticateObj), headers: {
        "content-type": "application/json",
        "x-authenticated-userid": "98a89719-0183-4f52-a83d-c1ce236e1a88||98a89719-0183-4f52-a83d-c1ce236e1a88",
      });
      // print("response: ${response.statusCode}");
      return jsonDecode(response.body);
    } catch (e) {
      // print("in catch");
      throw Exception(e);
    }
  }
}
