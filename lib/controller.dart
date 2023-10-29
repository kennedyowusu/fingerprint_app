import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuthenticationController extends GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final RxBool isAuthenticated = false.obs;

  Future<void> checkBiometrics() async {
    try {
      final hasBiometrics = await _localAuth.canCheckBiometrics;
      isAuthenticated.value = hasBiometrics;
    } catch (e) {
      print('Error while checking biometrics: $e');
    }
  }

  Future<void> authenticateWithFingerprint() async {
    try {
      final isAuthenticatedWithFingerprint = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
            stickyAuth: true,
            sensitiveTransaction: true,
            biometricOnly: true,
            useErrorDialogs: true),
      );
      isAuthenticated.value = isAuthenticatedWithFingerprint;
    } catch (e) {
      print('Error during fingerprint authentication: $e');
      isAuthenticated.value = false;
    }
  }
}
