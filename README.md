# app_security_kit

app_security_kit is a plugin for application preform series of security related actions e.g. creating public/pricate key, encode/decode string.

## Usage

### Password Encryption Function
```dart
import 'package:app_security_kit/password_encrypt_helper.dart';

/// Initialize 
PasswordEncryptHelper pwHelper = PasswordEncryptHelper(password: 'pAsSwOrD0321');

/// Encrypt String with given password
String encryptedString = pwHelper.encryptWPwd('String to be Encrypt');

/// Decrypt String with given password
///
/// return [String] if password is valid
/// return [null] if password is not valid
String decryptedString = pwHelper.decryptWPed(encryptedString);

```
### RSA functions
```dart
import 'package:app_security_kit/app_security_kit.dart';
import 'package:pointycastle/export.dart';

RsaKeyHelper rsaHelper = RsaKeyHelper();

/// Generate Key pairs
AsymmetricKeyPair keyPairs = rsaHelper.generateKeyPair();

/// Convert Keys into String
String publickeyPem = rsaHelper.encodePublicKeyToPem(keyPairs.publicKey);
String privatekeyPem = rsaHelper.encodePrivateKeyToPem(keyPairs.privateKey);

/// Convert String back into Keys
RSAPublicKey pbkeyFromPem = rsaHelper.parsePublicKeyFromPem(publickeyPem);
RSAPrivateKey pvkeyFromPem = rsaHelper.parsePrivateKeyFromPem(privatekeyPem);

/// Encrypt String
String encryptedString = rsaHelper.encrypt("Testing String", keyPairs.publicKey);

/// Decrypt String
String decryptedString = rsaHelper.decrypt(encryptedString, keyPairs.privateKey);
```

### Retrieve class
#### Extends from Retrieve
```dart
import 'package:app_security_kit/retrieve.dart';
import 'package:flutter/material.dart';

class TestRetrieve extends Retrieve {
  final String retrieve;
  final DateTime dateTime;

  final String customVal1;
  final String customVal2;

  TestRetrieve({
    @required this.retrieve,
    @required this.dateTime,
    @required this.customVal1,
    this.customVal2,
  }) : super(retrieve: retrieve, dateTime: dateTime);

  @override
  String toString() {
    return "retrieve=$retrieve&seq=$seq&customVal1=$customVal1${customVal2 != null ? "&customVal2=$customVal2" : ""}";
  }

  Object toJson() {
    return {
      "retrieve": retrieve,
      "seq": seq,
      "customVal1": customVal1,
      "customVal2": customVal2 == null ? '' : customVal2,
    };
  }
}
```

#### Generate Sign for api retrieve
```dart
DateTime testDateTime = DateTime.parse("2021-01-01");
TestRetrieve testRetrieve = TestRetrieve(
    retrieve: "testing",
    dateTime: testDateTime,
    customVal1: "cusVal1",
);

/// Using the Private Key to create sign
testRetrieve.setSign(keyPairs.privateKey);
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
