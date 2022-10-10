// ignore_for_file: library_prefixes

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as FSS;

class SecureStorage {
  static final SecureStorage _secureStorage = SecureStorage._internal();
  factory SecureStorage() {
    return _secureStorage;
  }
  SecureStorage._internal();

  final _storage = const FSS.FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future readSecureData(String key) async {
    try {
      var readData = await _storage.read(key: key);
      return readData;
    } catch (e) {
      return '';
    }
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
