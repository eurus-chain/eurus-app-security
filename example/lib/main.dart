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
  AsymmetricKeyPair<PublicKey, PrivateKey> keyPairs;

  final TextEditingController publicKyTc = TextEditingController();
  final TextEditingController privateKyTc = TextEditingController();

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
                      maxLines: 5,
                      controller: publicKyTc,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  )
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
                      maxLines: 5,
                      controller: privateKyTc,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ],
              ),
            ],
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

    String publickey = getStringPublickey();
    publicKyTc.text = publickey;
    String privatekey = getStringPrivatekey();
    privateKyTc.text = privatekey;
  }

  static AsymmetricKeyPair _genKeys(String dmy) {
    return RsaKeyHelper().generateKeyPair();
  }

  String getStringPublickey() {
    if (keyPairs == null) return '--empty--';
    return RsaKeyHelper().encodePublicKeyToPem(keyPairs.publicKey);
  }

  String getStringPrivatekey() {
    if (keyPairs == null) return '--empty--';
    return RsaKeyHelper().encodePrivateKeyToPem(keyPairs.privateKey);
  }

  void encryptString() {}
}
