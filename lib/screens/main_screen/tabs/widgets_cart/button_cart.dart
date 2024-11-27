import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/checkout_screen/checkout_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonCart extends StatelessWidget {
  const ButtonCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<CartProvider>(context);
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (cartprovider.cart.products.isEmpty) {
            Utils.showToast('Your cart is empty. Please add items to proceed.');
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CheckoutScreen()));
          }
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CHECKOUT',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
