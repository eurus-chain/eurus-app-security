import 'package:flutter_test/flutter_test.dart';
import 'package:app_security_kit/app_security_kit.dart';
import 'package:pointycastle/export.dart';

import 'test_retrieve.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  RsaKeyHelper rsaHelper = RsaKeyHelper();

  AsymmetricKeyPair keyPairs;
  group('RSA Helper', () {
    String publickeyPem;
    String privatekeyPem;

    test("Generate Key Pairs", () {
      keyPairs = rsaHelper.generateKeyPair();
      expect(true, keyPairs != null);
      expect(true, keyPairs.publicKey != null);
      expect(true, keyPairs.privateKey != null);
    });
    test("Key to String", () {
      publickeyPem = rsaHelper.encodePublicKeyToPem(keyPairs.publicKey);
      expect(true, publickeyPem != null);
      privatekeyPem = rsaHelper.encodePrivateKeyToPem(keyPairs.privateKey);
      expect(true, privatekeyPem != null);
    });
    test("String to Key", () {
      RSAPublicKey pbkeyFromPem = rsaHelper.parsePublicKeyFromPem(publickeyPem);
      expect(keyPairs.publicKey, pbkeyFromPem);
      RSAPrivateKey pvkeyFromPem =
          rsaHelper.parsePrivateKeyFromPem(privatekeyPem);
      expect(keyPairs.privateKey, pvkeyFromPem);
    });
    test("Encrypt/Decrypt String", () {
      String encryptedString =
          rsaHelper.encrypt("Testing String", keyPairs.publicKey);
      expect(true, encryptedString != null);
      String decryptedString =
          rsaHelper.decrypt(encryptedString, keyPairs.privateKey);
      expect("Testing String", decryptedString);
    });
  });

  group("Retrieve", () {
    DateTime testDateTime = DateTime.parse("2021-01-01");
    TestRetrieve testRetrieve = TestRetrieve(
      retrieve: "testing",
      dateTime: testDateTime,
      customVal1: "cusVal1",
    );
    test("Check datetime field", () {
      expect(testDateTime, testRetrieve.dateTime);
    });
    test("Check sequence", () {
      expect("${testDateTime.millisecondsSinceEpoch}-testing", testRetrieve.seq);
    });
    test("Test sign", () {
      testRetrieve.setSign(keyPairs.privateKey);
      expect(true, testRetrieve.sign != null);
    });
  });
}
