import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_security_kit/app_security_kit.dart';
import 'package:pointycastle/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                    children: [
                      Text("Encrypt / Decrypt", style: TextStyle(fontWeight: FontWeight.bold)),
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
        ),
      ),
    );
  }

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
