import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/views/MainScreen/screen_main.dart';
import 'package:e_commerce/views/CheckoutScreen/screen_checkout.dart';
import 'package:e_commerce/views/GetStartedScreen/screen_get_started.dart';
import 'package:e_commerce/views/NotificationsScreen/screen_notifications.dart';
import 'package:e_commerce/views/SignUpScreen/screen_sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/": (context) => const GetStartedScreen(),
        "/signUp": (context) => const ScreenSignUp(),
        "/main": (context) => const ScreenMain(),
        "/notifications": (context) => const ScreenNotifications(),
        "/checkout": (context) => const ScreenCheckout(),
      },
    );
  }
}
