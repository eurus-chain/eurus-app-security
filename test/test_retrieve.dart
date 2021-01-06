import 'package:app_security_kit/retrieve.dart';
import 'package:flutter/material.dart';

class TestRetrieve extends Retrieve {
  final String retrieve;

  final String customVal1;
  final String customVal2;

  TestRetrieve({
    @required this.retrieve,
    @required this.customVal1,
    this.customVal2,
  }) : super(retrieve: retrieve);

  @override
  String toString() {
    return "retrieve=$retrieve&seq=$seq&customVal1=$customVal1${customVal2 != null ? "&customVal2=$customVal2" : ""}";
  }

  Object toJson() {
    return {
      "retrieve": retrieve,
      "seq": seq,
      "customVal1": customVal1,
      "customVal2": customVal2 == null ? '' : customVal2,
    };
  }
}
