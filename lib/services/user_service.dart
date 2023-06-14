import 'package:doctive_sympthon_checker/main.dart';
import 'package:doctive_sympthon_checker/models/register_user_dto.dart';
import 'package:doctive_sympthon_checker/models/sign_in_dto.dart';
import 'package:doctive_sympthon_checker/models/user_dto.dart';
import 'package:doctive_sympthon_checker/models/user_personal_information.dart';
import 'package:doctive_sympthon_checker/models/user_update_dto.dart';
import 'package:doctive_sympthon_checker/models/verify_email_dto.dart';
import 'package:doctive_sympthon_checker/services/api_service.dart';
import 'package:doctive_sympthon_checker/services/crypto_service.dart';
import 'package:doctive_sympthon_checker/services/local_auth_service.dart';
import 'package:doctive_sympthon_checker/services/secret_service.dart';

class UserService {
  final _api = resolver<ApiService>();
  final _crypto = resolver<CryptoService>();
  final _secret = resolver<SecretService>();
  final _localAuth = resolver<LocalAuthService>();

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

  Future<String> getMnemonic() async {
    return await _secret.getSecret('user_mnemonic');
  }

  Future<bool> hasAccount() async {
    return await _secret.containsKeyInSecureData('user_mnemonic');
  }

  Future<bool> authenticate() async {
    return await _localAuth.authenticate();
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

  Future<UserDto> getProfile() async {
    return await _api.getProfile();
  }

  Future<void> updateProfile(UserUpdateDto dto) async {
    await _api.updateProfile(dto);
  }

  Future<void> updateUserPersonalInformation(
      UserPersonalInformation personalInformation) async {
    await _api.updateUserPersonalInformation(personalInformation);
  }

  Future<void> requestEmailVerification() async {
    final user = await getProfile();
    if (user.isEmailVerified) {
      throw Exception('Email is already verified');
    }

    await _api.getEmailVerificationToken();
  }

  Future<void> verifyEmail(String token) async {
    final mnemonic = await _secret.getSecret('user_mnemonic');
    final privateKey = _crypto.derivePrivateKeyFromMnemonic(mnemonic);
    final signature = _crypto.signMessageWithPrivateKey(token, privateKey);
    await _api.verifyEmail(VerifyEmailDto(
      token: token,
      signature: signature,
    ));
  }
}
