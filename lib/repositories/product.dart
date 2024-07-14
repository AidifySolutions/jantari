import 'dart:async';
import 'package:jantari/network_services/api_path.dart';
import 'package:jantari/network_services/http_client.dart';

// Models
import 'package:jantari/models/product.dart';

class ProductRepository {
  final HttpClient? httpClient;

  ProductRepository({this.httpClient});

  Future getProduct({
    required String? productCode
  }) async {
    final response = await HttpClient.instance.fetchData('${ApiPathHelper
        .getValue(APIPath.products)}/$productCode', null);

    Product parsedResponse = Product.fromJson(response);
    parsedResponse.stages?.forEach((stage) {
      stage.fieldCodes = [];
      stage.fields?.forEach((field) {
        stage.fieldCodes?.add(field.code!);
      });
    });

    return parsedResponse;
  }

  Future getProducts() async {
    final response = await HttpClient.instance.fetchData('${ApiPathHelper
        .getValue(APIPath.products)}?paginationOverride=true&type=0', null);

    List<Product> parsedResponse = response["items"].map<Product>((e) => Product
        .fromJson(e))
        .toList();

    return parsedResponse;
  }
}
