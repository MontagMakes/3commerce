import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutFormButton extends StatelessWidget {
  const CheckoutFormButton(
      {super.key,
      required this.formKey,
      required this.streetController,
      required this.cityController,
      required this.countryController});

  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController streetController;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    late BuildContext dialogContext;

    return Consumer2<OrderProvider, CartProvider>(
      builder: (context, orderProvider, cartProvider, child) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            logger.d('CheckoutForm: Submitting');
            String address =
                '${streetController.text},${cityController.text},${countryController.text}';
            try {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  dialogContext = context;
                  return const Dialog(
                    backgroundColor: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                },
              );

              await orderProvider.createOrder(
                  cartProvider.items, cartProvider.totalAmount, address);
              cartProvider.clearCart();

              if (context.mounted) {
                Navigator.pop(context);
              }

              logger.d('CheckoutForm: Submitted');
            } catch (e) {
              logger.e(e);
            } finally {
              if (context.mounted) {
                Navigator.pop(dialogContext);
              }
            }
          }
        },
        child: const Text("PLACE ORDER",
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
