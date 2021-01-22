import 'package:app_security_kit/app_security_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/pointycastle.dart';

class RSADemo extends StatefulWidget {
  @override
  _RSADemoState createState() => _RSADemoState();
}

class _RSADemoState extends State<RSADemo> {
  AsymmetricKeyPair keyPairs;

  final TextEditingController publicKyTc = TextEditingController();
  final TextEditingController privateKyTc = TextEditingController();

  final TextEditingController txtToEncrypt = TextEditingController();
  final TextEditingController txtEncrypted = TextEditingController();

  final TextEditingController txtToDecrypt = TextEditingController();
  final TextEditingController txtDecrypted = TextEditingController();

  @override
  void initState() {
    publicKyTc.text = '--empty--';
    privateKyTc.text = '--empty--';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '1. Generate Key Pairs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.start,
            ),
            FlatButton(
              onPressed: genKeyParis,
              child: Text("Generate Key Pair"),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Public Key"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    maxLines: 4,
                    controller: publicKyTc,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Private Key"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    maxLines: 4,
                    controller: privateKyTc,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '2. Encrypt / Decrypt',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          onPressed: encryptString,
                          child: Text(
                            "Click to Encrypt String",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            TextField(
                              controller: txtToEncrypt,
                            ),
                            TextField(
                              controller: txtEncrypted,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    onPressed: () {
                      txtToDecrypt.text = txtEncrypted.text;
                    },
                    child: Text("Copy Encrypted Text to decrypt"),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          onPressed: decryptString,
                          child: Text(
                            "Click to Decrypt String",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            TextField(
                              controller: txtToDecrypt,
                            ),
                            TextField(
                              controller: txtDecrypted,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void customFnc() {
  //   PasswordEncryptHelper pwdHelper =
  //       PasswordEncryptHelper(password: '019283');
  //   String encryptedVal = pwdHelper.encryptWPwd('0x5c6e6f530581a7dbcedef50afb195406f5073932609b0ed2cbf562322f51f237');
  //   print(encryptedVal);
  //   PasswordEncryptHelper wrongPwdHelper = PasswordEncryptHelper(password: '019282');
  //   String decryptedVal = wrongPwdHelper.decryptWPed(encryptedVal);
  //   print(decryptedVal);
  // }

  Future<void> genKeyParis() async {
    AsymmetricKeyPair keys = await compute(_genKeys, "dmy");

    setState(() {
      keyPairs = keys;
    });

    getStringPublickey();
    getStringPrivatekey();
  }

  static AsymmetricKeyPair _genKeys(String dmy) {
    return RsaKeyHelper().generateKeyPair();
  }

  void getStringPublickey() {
    if (keyPairs == null) return;
    publicKyTc.text = RsaKeyHelper().encodePublicKeyToPem(keyPairs.publicKey);
  }

  void getStringPrivatekey() {
    if (keyPairs == null) return;
    privateKyTc.text =
        RsaKeyHelper().encodePrivateKeyToPem(keyPairs.privateKey);
  }

  void encryptString() {
    if (txtToEncrypt.text == '') return;
    txtEncrypted.text =
        RsaKeyHelper().encrypt(txtToEncrypt.text, keyPairs.publicKey);
  }

  void decryptString() {
    if (txtToDecrypt.text == '') return;
    txtDecrypted.text =
        RsaKeyHelper().decrypt(txtToDecrypt.text, keyPairs.privateKey);
  }
}