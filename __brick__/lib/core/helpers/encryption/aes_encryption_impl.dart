import 'package:{{project_name}}/core/helpers/encryption/aes_encryption.dart';
import 'package:encrypt/encrypt.dart';

class AesEncryptionImpl extends AesEncryption {
  final Encrypter _encrypter;
  final IV _iv;

  AesEncryptionImpl({
    required String key,
    required String encodedIV,
    AESMode? mode,
  })  : _encrypter = Encrypter(AES(Key.fromUtf8(key), mode: mode ?? AESMode.sic)),
        _iv = IV.fromBase64(encodedIV);

  @override
  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase16(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  @override
  String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }
}
