import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

const String SALT = 'app_security_salt';
const String VAL_PROTOCOL_ST = '00St>>>>';
const String VAL_PROTOCOL_ED = '<<<<Ed00';

class PasswordEncryptHelper {
  /// Initialize helper with password
  PasswordEncryptHelper({required this.password});

  final String password;

  Uint8List get _base => _genBase();
  Uint8List get _key => _getKey();
  Uint8List get _iv => _getIV();

  RegExp _valProtocolRegex = RegExp(r"^00St>>>>(.*)<<<<Ed00$");

  /// Encrypt String with password
  ///
  /// return encrypted [String]
  String encryptWPwd(String s) {
    final sList = utf8.encode('$VAL_PROTOCOL_ST$s$VAL_PROTOCOL_ED');

    final encryptedList = _aesCbcEncrypt(Uint8List.fromList(sList));

    final encryptedString = base64.encode(encryptedList);

    return encryptedString;
  }

  /// Decrypt String with password
  ///
  /// return decrypted [String] if password is correct
  /// return [null] if password incorrect
  String? decryptWPed(String s) {
    final sList = base64.decode(s);

    final decryptedList = _aesCbcDecrypt(sList);

    final decryptedString =
        utf8.decode(decryptedList, allowMalformed: true).trim();
    if (!_valProtocolRegex.hasMatch(decryptedString)) return null;

    var contentGroup = _valProtocolRegex.allMatches(decryptedString);

    return contentGroup.elementAt(0).group(1);
  }

  /// Generate base for [_key] and [_iv]
  ///
  /// First 16 byptes for [_iv]
  /// Last 32 byptes for [_key]
  Uint8List _genBase() {
    KeyDerivator derivator = new PBKDF2KeyDerivator(
      HMac(SHA256Digest(), 48),
    );
    Pbkdf2Parameters params = new Pbkdf2Parameters(
      Uint8List.fromList(utf8.encode(SALT)),
      16,
      48,
    );
    derivator.init(params);
    var passphrase = utf8.encode(password);
    var result = derivator.process(Uint8List.fromList(passphrase));
    return result;
  }

  /// Generate encryption [_key]
  ///
  /// Get last 32 byptes from [_base]
  Uint8List _getKey() {
    return _base.sublist(16);
  }

  /// Generate encryption [_iv]
  ///
  /// Get first 16 byptes from [_base]
  Uint8List _getIV() {
    return _base.sublist(0, 16);
  }

  /// Add space at the end of the string
  ///
  /// return [Uint8List]
  Uint8List _addPaddingToFitBlockSize(Uint8List sList, int blockSize) {
    int spaceNeeded = 16 - sList.length % blockSize;

    if (spaceNeeded == 16) return sList;

    final encodedSpace = utf8.encode(' ');
    List<int> spaces = List.generate(
        spaceNeeded, (_) => encodedSpace.isNotEmpty ? encodedSpace[0] : 32);

    List<int> tempList = sList.toList();
    tempList.addAll(spaces);

    return Uint8List.fromList(tempList);
  }

  /// Encrypt incoming text in [Uint8List]
  ///
  /// return result in [Uint8List]
  Uint8List _aesCbcEncrypt(
    Uint8List paddedPlaintext,
  ) {
    // Create a CBC block cipher with AES, and initialize with key and IV
    final cbc = CBCBlockCipher(AESFastEngine())
      ..init(true, ParametersWithIV(KeyParameter(_key), _iv)); // true=encrypt

    paddedPlaintext = _addPaddingToFitBlockSize(paddedPlaintext, cbc.blockSize);

    // Encrypt the plaintext block-by-block
    final cipherText = Uint8List(paddedPlaintext.length); // allocate space

    var offset = 0;
    while (offset < paddedPlaintext.length) {
      offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
    }
    assert(offset == paddedPlaintext.length);

    return cipherText;
  }

  /// Decrypt incoming text in [Uint8List]
  ///
  /// return result in [Uint8List]
  Uint8List _aesCbcDecrypt(
    Uint8List cipherText,
  ) {
    // Create a CBC block cipher with AES, and initialize with key and IV
    final cbc = CBCBlockCipher(AESFastEngine())
      ..init(false, ParametersWithIV(KeyParameter(_key), _iv)); // false=decrypt

    // Decrypt the cipherText block-by-block
    final paddedPlainText = Uint8List(cipherText.length); // allocate space

    var offset = 0;
    while (offset < cipherText.length) {
      offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
    }
    assert(offset == cipherText.length);

    return paddedPlainText;
  }
}
