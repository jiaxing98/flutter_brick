import 'package:{{project_name}}/authentication.dart';
import 'package:{{project_name}}/core/exceptions/authentication_exception.dart';
import 'package:{{project_name}}/core/helpers/encryption/aes_encryption.dart';
import 'package:{{project_name}}/core/helpers/encryption/aes_encryption_impl.dart';
import 'package:{{project_name}}/core/env.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationImpl extends Authentication {
  final _biometricLoginEnabled = "key_biometric_login_enabled";
  final _biometricLoginUsername = "key_biometric_login_username";
  final _biometricLoginPassword = "key_biometric_login_password";

  final LocalAuthentication _auth = LocalAuthentication();

  final SharedPreferences _sp;
  final AesEncryption _aes;

  AuthenticationImpl({
    required SharedPreferences sp,
    required String key,
  })  : _sp = sp,
        _aes = AesEncryptionImpl(key: Env.aesKey);

  @override
  Future<bool> get canAuthenticateWithBiometrics async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  @override
  Future<bool> get isBiometricEnabled async {
    try {
      return _sp.getBool(_biometricLoginEnabled) ?? false;
    } on PlatformException catch (ex) {
      await _sp.remove(_biometricLoginEnabled);
      return false;
    }
  }

  @override
  Future<void> saveCaches(String username) async {
    final encrypted = _aes.encrypt(username);
    await _sp.setString(_biometricLoginUsername, encrypted);
  }

  @override
  Future<void> removeAllCaches() async {
    await _sp.remove(_biometricLoginUsername);
    await _sp.remove(_biometricLoginPassword);
    await _sp.remove(_biometricLoginEnabled);
  }

  @override
  Future<({String username, String password})> getCredential() async {
    final encryptedUsername = _sp.getString(_biometricLoginUsername);
    final encryptedPassword = _sp.getString(_biometricLoginPassword);

    if (encryptedUsername.isNullOrEmpty || encryptedPassword.isNullOrEmpty) {
      throw CredentialNotFoundException();
    }

    final username = _aes.decrypt(encryptedUsername!);
    final password = _aes.decrypt(encryptedPassword!);

    return (username: username, password: password);
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  @override
  Future<bool> authenticateWithBiometric(String localizedReason) async {
    return await _auth.authenticate(
      localizedReason: localizedReason,
      options: const AuthenticationOptions(biometricOnly: true),
    );
  }

  @override
  Future<void> enabledBiometricLogin(String password) async {
    final encrypted = _aes.encrypt(password);
    await _sp.setString(_biometricLoginPassword, encrypted);
    await _sp.setBool(_biometricLoginEnabled, true);
  }

  @override
  Future<void> disabledBiometricLogin() async {
    await _sp.setBool(_biometricLoginEnabled, false);
    await _sp.remove(_biometricLoginPassword);
  }
}
