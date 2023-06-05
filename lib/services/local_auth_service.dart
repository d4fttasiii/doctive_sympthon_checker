import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> authenticate() async {
    // bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
          options: const AuthenticationOptions(
            biometricOnly: false,            
          ));
    }

    return isAuthenticated;
  }
}
