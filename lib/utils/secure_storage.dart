import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  static final _storage = FlutterSecureStorage();
  static const _keyAccessToken = 'accessToken';
  static const _keyFCMToken = 'fcmToken';

  static Future setAccessToken(String accessToken) async => await _storage.write
    (key: _keyAccessToken, value: accessToken);
  static Future<String?> getAccessToken() async => await _storage.read(key:
  _keyAccessToken);

  static Future setFCMToken(String fcmToken) async => await _storage.write
    (key: _keyFCMToken, value: fcmToken);
  static Future<String?> getFCMToken() async => await _storage.read(key:
  _keyFCMToken);

  static Future deleteAllData() => _storage.deleteAll();
}
