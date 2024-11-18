import 'package:flutter/material.dart';

class Globals {
  static const List<String> categories = [
    "Electronics",
    "Furnitures",
    "Sports",
    "Toys",
    "Fashion",
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
