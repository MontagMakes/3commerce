import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/providers/provider_auth.dart';
import 'package:e_commerce/providers/provider_cart.dart';
import 'package:e_commerce/providers/provider_order.dart';
import 'package:e_commerce/providers/provider_product.dart';
import 'package:e_commerce/screens/FavouritesScreen/favourites.dart';
import 'package:e_commerce/screens/ModelViewScreen/model_view.dart';
import 'package:e_commerce/screens/MainScreen/screen_main.dart';
import 'package:e_commerce/screens/CheckoutScreen/screen_checkout.dart';
import 'package:e_commerce/screens/GetStartedScreen/screen_get_started.dart';
import 'package:e_commerce/screens/NotificationsScreen/screen_notifications.dart';
import 'package:e_commerce/screens/ProductDetailsScreen/product_details_screen.dart';
import 'package:e_commerce/screens/SignUpScreen/screen_sign_up.dart';
import 'package:e_commerce/services/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const debugging = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => getIt<ProviderAuth>()),
    ChangeNotifierProvider(create: (context) => getIt<ProviderCart>()),
    ChangeNotifierProvider(create: (context) => getIt<ProviderOrder>()),
    ChangeNotifierProvider(create: (context) => getIt<ProviderProduct>()),
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
      routes: {
        "/": (context) => const GetStartedScreen(),
        "/signUp": (context) => const ScreenSignUp(),
        "/main": (context) => const ScreenMain(),
        "/notifications": (context) => const ScreenNotifications(),
        "/checkout": (context) => const ScreenCheckout(),
        "/productDetails": (context) => const ProductDetailsScreen(),
        "/modelView": (context) => const ScreenModelView(),
        "/favourites": (context) => const ScreenFavourites(),
      },
    );
  }
}
