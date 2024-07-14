import 'dart:async';
import 'dart:convert';
import 'package:jantari/network_services/api_path.dart';
import 'package:jantari/network_services/http_client.dart';

class DocumentRepository {
  final HttpClient? httpClient;

  DocumentRepository({this.httpClient});

  // Future fetchDocument({required String? identifier}) async {
  //   final response = await HttpClient.instance.fetchData(
  //       '${ApiPathHelper.getValue(APIPath.documents)}/${StaticData.bucketCode}/$identifier',
  //       null);
  //
  //   return response;
  // }

  Future fetchDocumentByCode({
    required String? code,
    required String? productCode,
  }) async {
    final response = await HttpClient.instance.fetchData(
        '${ApiPathHelper.getValue(APIPath.documents)}/$productCode/$code',
        null);

    return response;
  }

  Future createDocument(
      {required String? code,
      required String? extension,
      required String? identifier,
      required String? file,
      required String? name,
        required String bucketCode,
      }) async {
    final requestBody = {
      "code": code,
      "extension": extension,
      "identifier": identifier,
      "file": file,
      "name": name,
      "isComplete": true,
      "bucketCode": bucketCode,
    };

    final response = await HttpClient.instance.postData(
        ApiPathHelper.getValue(APIPath.documents),
        json.encode(requestBody),
        null);

    // Document parsedResponse = Document.fromJson(response);

    return true;
  }
}
