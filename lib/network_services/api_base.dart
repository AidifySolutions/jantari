import 'package:flutter/foundation.dart';

class ApiBase {
  static String get baseURL {
    if (kReleaseMode) {
      return "https://graph.microsoft.com/v1.0";
    } else {
      return "https://graph.microsoft.com/v1.0";
    }
  }
}
