import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  final _storage = const FlutterSecureStorage();

  read(String key) async {
    String? value = await _storage.read(key: key) ?? "";
    return value;
  }

  write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  delete(String key) async {
    await _storage.delete(key: key);
  }

  deleteAll() async {
    await _storage.deleteAll();
  }

  readAll() async {
    return await _storage.readAll();
  }
}
