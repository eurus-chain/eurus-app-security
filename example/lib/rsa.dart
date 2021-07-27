import 'package:app_security_kit/app_security_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pointycastle/pointycastle.dart';

class RSADemo extends StatefulWidget {
  const RSADemo({Key? key}) : super(key: key);

  @override
  _RSADemoState createState() => _RSADemoState();
}

class _RSADemoState extends State<RSADemo> {
  AsymmetricKeyPair? keyPairs;

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
            TextButton(
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
                        child: TextButton(
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
                  TextButton(
                    onPressed: () {
                      txtToDecrypt.text = txtEncrypted.text;
                    },
                    child: Text("Copy Encrypted Text to decrypt"),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
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

  Future<void> genKeyParis() async {
    AsymmetricKeyPair keys = await RsaKeyHelper()
        .computeRSAKeyPair(RsaKeyHelper().getSecureRandom());

    setState(() {
      keyPairs = keys;
    });

    getStringPublickey();
    getStringPrivatekey();
  }

  void getStringPublickey() {
    if (keyPairs == null) return;
    publicKyTc.text = RsaKeyHelper()
        .encodePublicKeyToPemPKCS1(keyPairs!.publicKey as RSAPublicKey);
  }

  void getStringPrivatekey() {
    if (keyPairs == null) return;
    privateKyTc.text = RsaKeyHelper()
        .encodePrivateKeyToPemPKCS1(keyPairs!.privateKey as RSAPrivateKey);
  }

  void encryptString() {
    if (txtToEncrypt.text == '') return;
    txtEncrypted.text =
        encrypt(txtToEncrypt.text, keyPairs!.publicKey as RSAPublicKey);
  }

  void decryptString() {
    if (txtToDecrypt.text == '') return;
    txtDecrypted.text =
        decrypt(txtToDecrypt.text, keyPairs!.privateKey as RSAPrivateKey);
  }
}
