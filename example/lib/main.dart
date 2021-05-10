import 'package:app_security_kit_example/ra.dart';
import 'package:flutter/material.dart';

import 'rsa.dart';
import 'password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
            bottom: TabBar(
              tabs: [
                Padding(padding: EdgeInsets.all(15), child: Text('RA')),
                Padding(padding: EdgeInsets.all(15), child: Text('RSA')),
                Padding(padding: EdgeInsets.all(15), child: Text('Password')),
              ],
            ),
          ),
          body: TabBarView(
            children: [RADemo(), RSADemo(), PWDemo()],
          ),
        ),
      ),
    );
  }
}
