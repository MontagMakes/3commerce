import 'package:ecommerce/views/screen_sign_in.dart';
import 'package:ecommerce/views/screen_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AnimatedSignInScreen(),
    );
  }
}

