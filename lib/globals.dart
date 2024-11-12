import 'package:flutter/material.dart';

class Globals {
  static const List<String> categories = [
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
    "Category 5",
  ];

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  BoxDecoration themeColor() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF4081), Color(0xFFFF7043)],
      ),
    );
  }
}
