import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

/// Retrieve for api use
abstract class Retrieve {
  final String retrieve;
  final DateTime dateTime;

  Retrieve({required this.retrieve, required this.dateTime}) {
    _setSeq();
  }

  late String _sign;
  String get sign => _sign;

  late String _seq;
  String get seq => _seq;

  /// Create sign for api with privatekey
  void setSign(RSAPrivateKey privateKey) {
    RSASigner signer = RSASigner(SHA256Digest(), "0609608648016503040201");
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    _sign = base64Encode(signer
        .generateSignature(Uint8List.fromList(toString().codeUnits))
        .bytes);
  }

  /// Create sequence for tracing api calls
  void _setSeq() {
    _seq = "${dateTime.millisecondsSinceEpoch.toString()}-$retrieve";
  }
}
