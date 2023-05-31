import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'dart:typed_data';
import 'package:hex/hex.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/src/utils/typed_data.dart';
import 'package:web3dart/web3dart.dart';

class MsgSignature {
  MsgSignature(this.r, this.s, this.v);
  final BigInt r;
  final BigInt s;
  final int v;
}

class CryptoService {
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  bool isValidMnemonic(String mnemonic, {int requiredLength = 12}) {
    return bip39.validateMnemonic(mnemonic) &&
        mnemonic.split(' ').length == requiredLength;
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
    final messageHash = keccakUtf8(message);
    bip32.BIP32 pk = bip32.BIP32.fromBase58(privateKey);
    final signer = EthPrivateKey.fromInt(bytesToUnsignedInt(pk.privateKey!));
    final signature =
        signer.signPersonalMessageToUint8List(messageHash, chainId: 137);

    return HEX.encode(signature);
  }

  String stripHexPrefix(String input) =>
      input.startsWith('0x') ? input.substring(2) : input;
}
