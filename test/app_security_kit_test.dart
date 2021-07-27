import 'package:app_security_kit/password_encrypt_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_security_kit/app_security_kit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // RsaKeyHelper rsaHelper = RsaKeyHelper();

  // AsymmetricKeyPair keyPairs;
  // group('RSA Helper', () {
  //   String publickeyPem;
  //   String privatekeyPem;

  //   test("Generate Key Pairs", () {
  //     keyPairs = rsaHelper.generateKeyPair();
  //     expect(true, keyPairs != null);
  //     expect(true, keyPairs.publicKey != null);
  //     expect(true, keyPairs.privateKey != null);
  //   });
  //   test("Key to String", () {
  //     publickeyPem = rsaHelper.encodePublicKeyToPem(keyPairs.publicKey);
  //     expect(true, publickeyPem != null);
  //     privatekeyPem = rsaHelper.encodePrivateKeyToPem(keyPairs.privateKey);
  //     expect(true, privatekeyPem != null);
  //   });
  //   test("String to Key", () {
  //     RSAPublicKey pbkeyFromPem = rsaHelper.parsePublicKeyFromPem(publickeyPem);
  //     expect(keyPairs.publicKey, pbkeyFromPem);
  //     RSAPrivateKey pvkeyFromPem =
  //         rsaHelper.parsePrivateKeyFromPem(privatekeyPem);
  //     expect(keyPairs.privateKey, pvkeyFromPem);
  //   });
  //   test("Encrypt/Decrypt String", () {
  //     String encryptedString =
  //         rsaHelper.encrypt("Testing String", keyPairs.publicKey);
  //     expect(true, encryptedString != null);
  //     String decryptedString =
  //         rsaHelper.decrypt(encryptedString, keyPairs.privateKey);
  //     expect("Testing String", decryptedString);
  //   });
  // });

  // group("Retrieve", () {
  //   DateTime testDateTime = DateTime.parse("2021-01-01");
  //   TestRetrieve testRetrieve = TestRetrieve(
  //     retrieve: "testing",
  //     dateTime: testDateTime,
  //     customVal1: "cusVal1",
  //   );
  //   test("Check datetime field", () {
  //     expect(testDateTime, testRetrieve.dateTime);
  //   });
  //   test("Check sequence", () {
  //     expect(
  //         "${testDateTime.millisecondsSinceEpoch}-testing", testRetrieve.seq);
  //   });
  //   test("Test sign", () {
  //     testRetrieve.setSign(keyPairs.privateKey);
  //     expect(true, testRetrieve.sign != null);
  //   });
  // });

  group("Encryption with Password", () {
    final String correctPW = '190814';
    final String wrongPW = '000000';
    final String dummyString =
        'f4f666f91a885ce964a7355b878cc7e201e1378ab0b9fb8c22afec10142b760f';
    final String encryptedString =
        'NwlRTvULY6lxC4EbUWBarsECkLjep+ljD3u2kgfRO8Gzj2HChzv6CMsrWy25vN4kxg4bZTl711sVp7uUX5vqxlTSctkS/El4D1QLA66hEQw=';

    test("Encrypt String with correct password", () {
      PasswordEncryptHelper pwHelper =
          PasswordEncryptHelper(password: correctPW);
      String result = pwHelper.encryptWPwd(dummyString);
      expect(result, encryptedString);
    });

    test("Decrypt String correct password", () {
      PasswordEncryptHelper pwHelper =
          PasswordEncryptHelper(password: correctPW);
      String? result = pwHelper.decryptWPed(encryptedString);
      expect(result, dummyString);
    });

    test("Decrypt String wrong password", () {
      PasswordEncryptHelper pwHelper = PasswordEncryptHelper(password: wrongPW);
      String? result = pwHelper.decryptWPed(encryptedString);
      expect(result, null);
    });
  });
}
