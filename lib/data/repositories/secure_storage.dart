import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageKey { accessToken }

class SecureStorage {
  late final FlutterSecureStorage storage;

  void init() {
    storage = FlutterSecureStorage();
  }

  Future<String?> read(SecureStorageKey key) async {
    return await storage.read(key: key.name);
  }

  Future write(SecureStorageKey key, String value) async {
    await storage.write(key: key.name, value: value);
  }

  Future delete(SecureStorageKey key) async {
    await storage.delete(key: key.name);
  }
}
