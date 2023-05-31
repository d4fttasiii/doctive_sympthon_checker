import 'package:doctive_sympthon_checker/main.dart';
import 'package:doctive_sympthon_checker/models/register_user_dto.dart';
import 'package:doctive_sympthon_checker/models/sign_in_dto.dart';
import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:doctive_sympthon_checker/services/api_service.dart';
import 'package:doctive_sympthon_checker/services/crypto_service.dart';
import 'package:doctive_sympthon_checker/services/secret_service.dart';

class UserService {
  final _api = resolver<ApiService>();
  final _crypto = resolver<CryptoService>();
  final _secret = resolver<SecretService>();

  Future<void> register(String mnemonic, RegisterUserDto dto) async {
    final regMsgResponse = await _api.getRegistrationMessage();
    final address = _crypto.deriveAddressFromMnemonic(mnemonic);
    final privateKey = _crypto.derivePrivateKeyFromMnemonic(mnemonic);
    final signature =
        _crypto.signMessageWithPrivateKey(regMsgResponse.message, privateKey);

    final result = await _api.register(
      RegisterUserDto(
          walletAddress: address,
          firstname: dto.firstname,
          lastname: dto.lastname,
          email: dto.email,
          message: regMsgResponse.message,
          signature: signature),
    );

    await _secret.storeSecret('user_mnemonic', mnemonic);
    await signIn();
  }

  Future<bool> restore(String mnemonic) async {
    try {
      if (!_crypto.isValidMnemonic(mnemonic)) {
        return false;
      }

      final privateKey = _crypto.derivePrivateKeyFromMnemonic(mnemonic);
      final address = _crypto.deriveAddressFromMnemonic(mnemonic);
      final messageResponse = await _api.generateSignInMessage(address);
      final signature = _crypto.signMessageWithPrivateKey(
          messageResponse.message, privateKey);
      final signInResponse = await _api
          .signIn(SignInDto(walletAddress: address, signature: signature));
      await _secret.storeSecret('user_mnemonic', mnemonic);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<UserDto> getProfile() async {
    return await _api.getProfile();
  }

  Future<void> signIn() async {
    final mnemonic = await _secret.getSecret('user_mnemonic');
    final privateKey = _crypto.derivePrivateKeyFromMnemonic(mnemonic);
    final address = _crypto.deriveAddressFromMnemonic(mnemonic);

    final messageResponse = await _api.generateSignInMessage(address);
    final signature =
        _crypto.signMessageWithPrivateKey(messageResponse.message, privateKey);
    final signInResponse = await _api
        .signIn(SignInDto(walletAddress: address, signature: signature));
  }
}
