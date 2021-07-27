import 'package:app_security_kit/password_encrypt_helper.dart';
import 'package:flutter/material.dart';

class PWDemo extends StatefulWidget {
  @override
  _PWDemoState createState() => _PWDemoState();
}

class _PWDemoState extends State<PWDemo> {
  final TextEditingController eTc = TextEditingController();
  final TextEditingController ebTc = TextEditingController();
  final TextEditingController eaTc = TextEditingController();

  final TextEditingController dTc = TextEditingController();
  final TextEditingController dbTc = TextEditingController();
  final TextEditingController daTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Encrypt", style: TextStyle(fontSize: 21)),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Password"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: eTc,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Text to encrypt"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: ebTc,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                if (eTc.text == '' || ebTc.text == '') return;
                PasswordEncryptHelper? pwHelper = PasswordEncryptHelper(password: eTc.text);
                eaTc.text = pwHelper.encryptWPwd(ebTc.text);
                pwHelper = null;
              },
              child: Text("Encrypt"),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Encrypted Text"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: eaTc,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  if (eaTc.text == '') return;
                  dbTc.text = eaTc.text;
                },
                child: Text('Copy to decrypt'),
              ),
            ),
            Text("Decrypt", style: TextStyle(fontSize: 21)),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Password"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: dTc,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Text to decrypt"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: dbTc,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                if (dTc.text == '' || dbTc.text == '') return;
                PasswordEncryptHelper? pwHelper = PasswordEncryptHelper(password: dTc.text);
                final result = pwHelper.decryptWPed(dbTc.text);
                pwHelper = null;
                daTc.text = result ?? '--Incorrect Password--';
              },
              child: Text("Decrypt"),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Decrypted Text"),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: daTc,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
