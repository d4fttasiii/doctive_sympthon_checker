import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hashlib/hashlib.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'dart:typed_data';
import 'package:hex/hex.dart';

class CryptoService {
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  String derivePrivateKeyFromMnemonic(String mnemonic) {
    Uint8List seed = bip39.mnemonicToSeed(mnemonic);
    bip32.BIP32 masterKey = bip32.BIP32.fromSeed(seed);
    bip32.BIP32 privateKey = masterKey.derivePath("m/44'/60'/0'/0/0");

    return privateKey.toBase58();
  }

  String deriveAddressFromMnemonic(String mnemonic) {
    String pk = derivePrivateKeyFromMnemonic(mnemonic);
    bip32.BIP32 privateKey = bip32.BIP32.fromBase58(pk);

    return ethereumAddressFromPublicKey(privateKey.publicKey);
  }

  String derivePublicKeyFromMnemonic(String mnemonic) {    
    String pk = derivePrivateKeyFromMnemonic(mnemonic);
    bip32.BIP32 privateKey = bip32.BIP32.fromBase58(pk);

    return HEX.encode(privateKey.publicKey);
  }

  String signMessageWithPrivateKey(
    String message,
    String privateKey,
  ) {
    bip32.BIP32 signer = bip32.BIP32.fromBase58(privateKey);
    HashDigest hash = keccak256.string(message);
    var signature = signer.sign(hash.bytes);

    return HEX.encode(signature);
  }

  bool verifySignature(String message, String signature, String publicKeyHex){
    Uint8List pubBytes = Uint8List.fromList(HEX.decode(publicKeyHex));
    bip32.BIP32 pubKey = bip32.BIP32.fromPublicKey(pubBytes, Uint8List.fromList([60]));
    HashDigest hash = keccak256.string(message);
    bool result = pubKey.verify(hash.bytes, Uint8List.fromList(HEX.decode(signature)));

    return result;
  }

  String stripHexPrefix(String input) =>
      input.startsWith('0x') ? input.substring(2) : input;
}
