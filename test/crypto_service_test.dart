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

    test('should sign and verify signature', () {
      String privateKey =
          cryptoService.derivePrivateKeyFromMnemonic(testMnemonic);
      String publicKey =
          cryptoService.derivePublicKeyFromMnemonic(testMnemonic);
      String signature =
          cryptoService.signMessageWithPrivateKey(message, privateKey);
      bool result =
          cryptoService.verifySignature(message, signature, publicKey);
      expect(result, true);
    });

    test('should sign and verify invalid signature', () {
      String publicKey =
          cryptoService.derivePublicKeyFromMnemonic(testMnemonic);
      bool result = cryptoService.verifySignature(
          message,
          'a02d5d45da944c85359dca4b873af2ddae977e34fe51652980b44e1a6fd98931048bee805178cfcdf9d12241cb08c80d33d664a80262f6a659201c796a6b2116',
          publicKey);
      expect(result, false);
    });
  });
}
