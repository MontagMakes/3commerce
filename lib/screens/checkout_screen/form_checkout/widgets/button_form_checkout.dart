import 'package:e_commerce/globals.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/screens/main_screen/main_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonFormCheckout extends StatelessWidget {
  const ButtonFormCheckout({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.updateLoadingState,
    required this.streetController,
    required this.cityController,
    required this.countryController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Function(bool) updateLoadingState;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderProvider, CartProvider>(
      builder: (context, orderProvider, cartProvider, child) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            updateLoadingState(true);
            logger.d('CheckoutForm: Submitting');
            String address =
                '${streetController.text},${cityController.text},${countryController.text}';
            try {
              await orderProvider.createOrder(cartProvider.cart.products,
                  cartProvider.cart.totalPrice, address);
              cartProvider.clearCart();

              Navigator.pushReplacement(
                  Globals.scaffoldKey.currentContext!,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ));
              Utils.showToast('Order Placed Successfully');
              logger.d('CheckoutForm: Submitted');
            } catch (e) {
              logger.e(e);
            } finally {
              updateLoadingState(false);
            }
          }
        },
        child: const Text("PLACE ORDER",
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
