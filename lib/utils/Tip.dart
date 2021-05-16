import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tip {
  static int last = 0;
  static var preMsg;

  static show({msg, bool longShow = false, bool isWarning = false}) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 800) {
      last = DateTime.now().millisecondsSinceEpoch;
      Fluttertoast.showToast(
          msg: msg,
          backgroundColor: Colors.black54,
          fontSize: 14.0,
          toastLength: longShow ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else {
      if (preMsg != msg) {
        Fluttertoast.showToast(
            msg: msg,
            backgroundColor: Colors.black54,
            fontSize: 14.0,
            toastLength: longShow ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    }
    preMsg = msg;
  }
}
