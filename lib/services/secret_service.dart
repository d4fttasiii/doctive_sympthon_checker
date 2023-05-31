import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecretService {
  final _secureStorage = const FlutterSecureStorage();

  Future<String> getSecret(String key) async {
    try {
      final secret =
          await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
      return secret!;
    } catch (err) {
      throw Exception('Secret not found');
    }
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  Future storeSecret(
    String key,
    String secret,
  ) async {
    const storage = FlutterSecureStorage();
    await storage.write(
        key: key, value: secret, aOptions: _getAndroidOptions());
  }

  Future removeSecret(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
