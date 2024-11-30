import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/screens/create_product_screen/create_product_screen.dart';
import 'package:e_commerce/screens/main_screen/tabs/widgets_settings/options_tile_settings.dart';
import 'package:e_commerce/screens/main_screen/tabs/widgets_settings/profile_section_settings.dart';
import 'package:e_commerce/screens/my_products_screen/my_products_screen.dart';
import 'package:e_commerce/screens/order_history_screen/order_history_screen.dart';
import 'package:e_commerce/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const ProfileSectionSettings(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                OptionTile(
                    icon: Icons.add_box,
                    title: 'Create Product Listing',
                    ontap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateProductScreen(),
                        ))),
                OptionTile(
                    icon: Icons.add_box,
                    title: 'My products',
                    ontap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyProductsScreen(),
                        ))),
                OptionTile(
                    icon: Icons.local_shipping,
                    title: 'Order History',
                    ontap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderHistoryScreen()))),
                Consumer2<UserProvider, CartProvider>(
                  builder: (context, userProvider, cartProvider, child) => OptionTile(
                    icon: Icons.logout,
                    title: 'Sign Out',
                    ontap: () async {
                      await userProvider.signOut();
                      cartProvider.clearCart();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
