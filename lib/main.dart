import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/providers/provider_cart.dart';
import 'package:e_commerce/providers/provider_favourites.dart';
import 'package:e_commerce/providers/provider_order.dart';
import 'package:e_commerce/providers/provider_product.dart';
import 'package:e_commerce/providers/provider_user.dart';
import 'package:e_commerce/screens/FavouritesScreen/favourites.dart';
import 'package:e_commerce/screens/ModelViewScreen/model_view.dart';
import 'package:e_commerce/screens/MainScreen/screen_main.dart';
import 'package:e_commerce/screens/CheckoutScreen/screen_checkout.dart';
import 'package:e_commerce/screens/MyProductsScreen/my_products_screen.dart';
import 'package:e_commerce/screens/SignInScreen/screen_sign_in.dart';
import 'package:e_commerce/screens/NotificationsScreen/screen_notifications.dart';
import 'package:e_commerce/screens/ProductDetailsScreen/product_details_screen.dart';
import 'package:e_commerce/screens/SignUpScreen/screen_sign_up.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const debugging = false;

// Main function that starts the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  // Using provider functions for state management
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProviderUser()),
    ChangeNotifierProvider(create: (context) => ProviderCart()),
    ChangeNotifierProvider(create: (context) => ProviderOrder()),
    ChangeNotifierProvider(create: (context) => ProviderFavourites()),
    ChangeNotifierProvider(create: (context) => ProviderProduct()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: debugging == true ? "/main" : "/",

      // using named routes, for better routing
      routes: {
        "/": (context) => const SignInScreen(),
        "/signUp": (context) => const ScreenSignUp(),
        "/main": (context) => const ScreenMain(),
        "/myProducts": (context) => const MyProductsScreen(),
        "/notifications": (context) => const ScreenNotifications(),
        "/checkout": (context) => const ScreenCheckout(),
        "/productDetails": (context) => const ProductDetailsScreen(),
        "/modelView": (context) => const ScreenModelView(),
        "/favourites": (context) => const ScreenFavourites(),
      },
    );
  }
}
