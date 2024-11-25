import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static var appBarGradient = const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFF7080), Color(0xFFFF4081)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static Future<bool?> showToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
