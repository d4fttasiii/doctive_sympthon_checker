import 'package:doctive_sympthon_checker/services/crypto_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CryptoService', () {
    CryptoService cryptoService = CryptoService();
    String testMnemonic =
        'myself beyond ozone normal tuna trick general defense divert knee garlic pizza';
    String expectedAddress = '0x6D7ed0C8929dcd91E22Cab53a0F383aBc5B55633';
    String message = 'Hello World';

    test('should generate a mnemonic of 12 words', () {
      String mnemonic = cryptoService.generateMnemonic();
      expect(mnemonic.split(' ').length, 12);
    });

    test('should derive the same private key from the same mnemonic', () {
      String privateKey =
          cryptoService.derivePrivateKeyFromMnemonic(testMnemonic);
      String privateKey2 =
          cryptoService.derivePrivateKeyFromMnemonic(testMnemonic);
      expect(privateKey, privateKey2);
    });

    test('should derive the same address from the same mnemonic', () {
      String address = cryptoService.deriveAddressFromMnemonic(testMnemonic);
      String address2 = cryptoService.deriveAddressFromMnemonic(testMnemonic);
      expect(address, address2);
    });

    test('should derive the correct address', () {
      String address = cryptoService.deriveAddressFromMnemonic(testMnemonic);
      expect(address, expectedAddress);
    });

    test('should sign message without problems', () {
      String privateKey =
          cryptoService.derivePrivateKeyFromMnemonic(testMnemonic);
      String signature =
          cryptoService.signMessageWithPrivateKey(message, privateKey);

      expect(signature,
          '54902f527ef6fb04fa2be57e89a4aa92c9eb8b9b7aacfc85f79c3023ad0755857ec3615142acf030b326d3f517f223ca8de876ed6bb115ea00ff78b184e29c5e0136');
    });
  });
}
