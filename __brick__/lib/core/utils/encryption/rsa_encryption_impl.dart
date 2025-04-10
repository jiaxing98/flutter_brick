import 'package:{{project_name}}/core/utils/encryption/rsa_encryption.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RsaEncryptionImpl extends RsaEncryption {
  final Encrypter _encrypter;

  RsaEncryptionImpl({
    required String key,
    required RSAPublicKey publicKey,
    required RSAPrivateKey privateKey,
  }) : _encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));

  @override
  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase16(encryptedText);
    return _encrypter.decrypt(encrypted);
  }

  @override
  String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText);
    return encrypted.base64;
  }
}
