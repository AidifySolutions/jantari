import 'dart:convert';
import 'dart:io';
import 'package:jantari/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_base.dart';
import 'api_exception.dart';

// const authorization = "Bearer Yh32eQwRucDxAsJdXL4PGmlCsgRCFOx5";

class HttpClient {
  static final HttpClient _singleton = HttpClient();

  static HttpClient get instance => _singleton;

  Future<dynamic> fetchData(String url, BuildContext? context,
      {Map<String, dynamic>? params, String? queryString}) async {
    String? token = await SecureStorage.getAccessToken();
    final authorization = "Bearer $token";

    var responseJson;

    var uri = ApiBase.baseURL +
        url +
        ((queryString != null) ? queryString : "") +
        ((params != null) ? queryParameters(params) : "");

    print("GET: ${Uri.parse(uri)}");
    try {
      final response = await http.get(Uri.parse(uri), headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "x-authenticated-userid": "98a89719-0183-4f52-a83d-c1ce236e1a88||98a89719-0183-4f52-a83d-c1ce236e1a88",
        "authorization": authorization,
      });
      responseJson = _returnResponse(response, context: context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  String queryParameters(Map<String, dynamic> params) {
    final jsonString = Uri(queryParameters: params);
    // final jsonString = Uri(queryParameters: params);
    return '?${jsonString.query}';
  }

  Future<dynamic> postData(String url, dynamic body, BuildContext? context,
      {Map<String, String>? params, String? token, bool excludeBaseURL =
      false, Map<String, String>? headers}) async {
    String? token = await SecureStorage.getAccessToken();
    final authorization = "Bearer $token";

    var responseJson;

    var uri = excludeBaseURL ? url : ApiBase.baseURL +
        url +
        ((params != null) ? this.queryParameters(params) : "");

    print("POST: ${Uri.parse(uri)}");
    try {
      var response = await http.post(Uri.parse(uri), body: body, headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "x-authenticated-userid": "98a89719-0183-4f52-a83d-c1ce236e1a88||98a89719-0183-4f52-a83d-c1ce236e1a88",
        "authorization": authorization,
        ...(headers ?? {})
      });
      responseJson = _returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putData(String url, dynamic body, BuildContext context,
      {String? token}) async {
    String? token = await SecureStorage.getAccessToken();
    final authorization = "Bearer $token";

    var responseJson;
    print("PUT: ${Uri.parse(ApiBase.baseURL + url)}");
    try {
      final response = await http
          .put(Uri.parse(ApiBase.baseURL + url), body: body, headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": authorization
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteData(String url, BuildContext context,
      {String? token}) async {
    String? token = await SecureStorage.getAccessToken();
    final authorization = "Bearer $token";

    var responseJson;
    var uri = ApiBase.baseURL + url;
    print("DELETE: ${Uri.parse(uri)}");
    try {
      final response = await http.delete(Uri.parse(uri), headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": authorization
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response, {BuildContext? context}) {
    switch (response.statusCode) {
      case 201:
      case 202:
      case 200:
      case 302:
        var responseJson = response.body.isNotEmpty
            ? json.decode(response.body.toString())
            : null;
        return responseJson;
      case 400:
        var responseJson = response.body.isNotEmpty
            ? json.decode(response.body.toString())
            : null;
        throw BadRequestException(responseJson["message"]);
      case 401:
        var responseJson = response.body.isNotEmpty
            ? json.decode(response.body.toString())
            : null;
        throw responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
