import 'dart:convert';
import 'dart:typed_data';

import 'package:app_security_kit/rsa_pem.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

class DecryptionHelper {
  /// Initialize helper with private key
  DecryptionHelper({required this.privateKey});

  final String privateKey;
  RSAPrivateKey get _privateKey =>
      RsaKeyHelper().parsePrivateKeyFromPem(privateKey);

  /// RA Decryption Flow
  ///
  /// 1. Initialize Helper with private key
  /// 2. Decode incoming string using base64
  /// 3. Splite bytes into three parts
  ///     {Offset - 4 bytes}{Encrypted AES Key - 128 bytes}{Encryped Content - rest of it}
  /// 4. Decrypte Encrtyped AES Key with Private Key
  /// 5. Decrypte Encrypted content with AES Key
  String decryptRAEncryption(String input) {
    // Decode content with base64
    Uint8List wholeEncrypted = base64.decode(input);

    // Extract encrypted AES Key part and Encrypted context part
    Uint8List rsaEncryptedAesKey = wholeEncrypted.sublist(4, 132);
    Uint8List aesEncryptedVal = wholeEncrypted.sublist(132);

    // Decrypte encrypted AES Key
    String aesKey = _decryptRSACiphertext(rsaEncryptedAesKey, _privateKey);
    // Convert AES Key to bytes
    Uint8List aesKeyByte = base64.decode(aesKey);

    // Decrypte content by AES Key
    Uint8List decryptedBytes = _decryptAESCipher(aesEncryptedVal, aesKeyByte);

    return String.fromCharCodes(decryptedBytes);
  }

  /// Decode encryped RSA Uint8List
  String _decryptRSACiphertext(Uint8List ciphertextBytes, RSAPrivateKey pk) {
    String stringToDecode = String.fromCharCodes(ciphertextBytes);

    return decrypt(stringToDecode, pk);
  }

  Uint8List _decryptAESCipher(Uint8List cipertextBytes, Uint8List key) {
    KeyParameter keyParam = KeyParameter(key);
    BlockCipher aes = AESFastEngine();

    Uint8List iv = Uint8List(aes.blockSize)
      ..setRange(0, aes.blockSize, cipertextBytes);

    ParametersWithIV params = ParametersWithIV(keyParam, iv);
    BlockCipher cipher = CBCBlockCipher(aes);

    cipher.init(false, params);

    int cipherLen = cipertextBytes.length - aes.blockSize;
    Uint8List cipherBytes = new Uint8List(cipherLen)
      ..setRange(0, cipherLen, cipertextBytes, aes.blockSize);
    Uint8List paddedText = _processBlocks(cipher, cipherBytes);
    Uint8List textBytes = _unpad(paddedText);

    return textBytes;
  }

  static Uint8List _processBlocks(BlockCipher cipher, Uint8List inp) {
    var out = new Uint8List(inp.lengthInBytes);

    for (var offset = 0; offset < inp.lengthInBytes;) {
      var len = cipher.processBlock(inp, offset, out, offset);
      offset += len;
    }

    return out;
  }

  static Uint8List _unpad(Uint8List src) {
    var pad = new PKCS7Padding();
    pad.init(null);

    int padLength = pad.padCount(src);
    int len = src.length - padLength;

    return new Uint8List(len)..setRange(0, len, src);
  }
}
