import 'package:local_auth/local_auth.dart';

abstract class BiometricAuthentication {
  Future<bool> get canAuthenticateWithBiometrics;
  Future<bool> get isBiometricEnabled;

  Future<void> saveCaches(String username);
  Future<void> removeAllCaches();

  Future<({String username, String password})> getCredential();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<bool> authenticateWithBiometric(String localizedReason);
  Future<void> enableBiometricLogin(String password);
  Future<void> disableBiometricLogin();
}
