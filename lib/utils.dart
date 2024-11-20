import 'package:flutter/material.dart';

class Utils {
  static var appBarGradient = const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFF7080), Color(0xFFFF4081)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
