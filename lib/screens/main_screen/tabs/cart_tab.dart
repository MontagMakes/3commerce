import 'package:e_commerce/screens/main_screen/tabs/widgets_cart/button_cart.dart';
import 'package:e_commerce/screens/main_screen/tabs/widgets_cart/list_cart.dart';
import 'package:e_commerce/screens/main_screen/tabs/widgets_cart/total_amount_cart.dart';
import 'package:flutter/material.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Column(
        children: [
          ListCart(),
          TotalAmountCart(),
          ButtonCart(),
        ],
      ),
    );
  }
}
