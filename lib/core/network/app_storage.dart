import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vma/core/enums/app_storage_keys.dart';

class AppStorage {
  static const _storage = FlutterSecureStorage();

  static Future<String?> read(AppStorageKeys key) async {
    String? value = await _storage.read(key: key.name);
    return value;
  }

  static Future write(AppStorageKeys key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  static Future delete(AppStorageKeys key) async {
    await _storage.delete(key: key.name);
  }

  static Future deleteAll() async {
    await _storage.deleteAll();
  }

  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
