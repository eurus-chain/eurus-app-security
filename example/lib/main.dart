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
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
            bottom: TabBar(
              tabs: [
                Padding(padding: EdgeInsets.all(15), child: Text('Password')),
                Padding(padding: EdgeInsets.all(15), child: Text('RSA')),
              ],
            ),
          ),
          body: TabBarView(
            children: [PWDemo(), RSADemo()],
          ),
        ),
      ),
    );
  }
}
