import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract final class KeySecureStorage {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}

@LazySingleton()
class SecureStorageService {
  SecureStorageService(this._flutterSecureStorage);

  final FlutterSecureStorage _flutterSecureStorage;

  Future<void> write(String key, String data) async {
    return await _flutterSecureStorage.write(key: key, value: data);
  }

  Future<String?> read(String key) async {
    return await _flutterSecureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    return await _flutterSecureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    return await _flutterSecureStorage.deleteAll();
  }
}
