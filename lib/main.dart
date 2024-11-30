import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();

// Main function that starts the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  // Using provider functions for state management
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProxyProvider<UserProvider, ProductProvider>(
      create: (context) => ProductProvider(),
      update: (context, providerUser, productProvider) =>
          productProvider!..updateUserProvider(providerUser),
    ),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      home: const SignInScreen(),
    );
  }
}
