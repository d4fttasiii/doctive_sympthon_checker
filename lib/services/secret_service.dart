import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecretService {
  Future<String> getSecret(String key) async {
    const storage = FlutterSecureStorage();
    try {
      final secret = await storage.read(key: key);
      return secret!;
    } catch (err) {
      throw Exception('Secret not found');
    }
  }

  Future storeSecret(
    String key,
    String secret,
  ) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: secret);
  }

  Future removeSecret(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }
}
