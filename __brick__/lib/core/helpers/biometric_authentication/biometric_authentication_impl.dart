import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{project_name}}/core/extensions/string_extension.dart';
import 'package:{{project_name}}/core/helpers/biometric_authentication/biometric_authentication.dart';
import 'package:{{project_name}}/core/helpers/biometric_authentication/exception.dart';
import 'package:{{project_name}}/core/helpers/encryption/aes_encryption.dart';
import 'package:{{project_name}}/core/helpers/encryption/aes_encryption_impl.dart';

class BiometricAuthenticationImpl extends BiometricAuthentication {
  final _biometricLoginEnabled = "key_biometric_login_enabled";
  final _biometricLoginUsername = "key_biometric_login_username";
  final _biometricLoginPassword = "key_biometric_login_password";

  final LocalAuthentication _auth = LocalAuthentication();

  final SharedPreferences _sp;
  final AesEncryption _aes;

  BiometricAuthenticationImpl({
    required SharedPreferences sp,
    required String key,
    required String encodedIV,
  })  : _sp = sp,
        _aes = AesEncryptionImpl(key: key, encodedIV: encodedIV);

  @override
  Future<bool> get canAuthenticateWithBiometrics async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  @override
  Future<bool> get isBiometricEnabled async {
    try {
      return _sp.getBool(_biometricLoginEnabled) ?? false;
    } on PlatformException catch (ex, stacktrace) {
      log(ex.toString(), stackTrace: stacktrace);
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
      throw CredentialCorruptedException();
    }

    try {
      final username = _aes.decrypt(encryptedUsername!);
      final password = _aes.decrypt(encryptedPassword!);

      return (username: username, password: password);
    } catch (ex, stacktrace) {
      log(ex.toString(), stackTrace: stacktrace);
      throw CredentialCorruptedException();
    }
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
