import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/screens/checkout_screen/widgets/address_form_checkout.dart';
import 'package:e_commerce/screens/checkout_screen/widgets/payment_form_checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController streetController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late BuildContext dialogContext;

  bool isLoading = false;

  void updateLoadingState(bool newIsloading) {
    setState(() {
      isLoading = newIsloading;
    });
  }

  @override
  void dispose() {
    super.dispose();
    countryController.dispose();
    cityController.dispose();
    streetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.grey)),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Shipping Address Form
                AddressFormCheckout(
                    countryController: countryController,
                    cityController: cityController,
                    streetController: streetController),
                const SizedBox(height: 20),

                // Payment Method Form
                const PaymentFormCheckout(),
                const SizedBox(height: 20),

                // Total Amount
                const Text("TOTAL AMOUNT",
                    style: TextStyle(color: Colors.grey)),

                // Checkout Button
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) => Text(
                      "\$${cartProvider.totalAmount}",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                // Checkout Button
                Consumer2<OrderProvider, CartProvider>(
                  builder: (context, orderProvider, cartProvider, child) =>
                      ElevatedButton(
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
                          await orderProvider.createOrder(
                              cartProvider.cart.products,
                              cartProvider.totalAmount,
                              address);
                          cartProvider.clearCart();

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                          logger.d('CheckoutForm: Submitted');
                        } catch (e) {
                          logger.e(e);
                        } finally {
                          updateLoadingState(true);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                    child: const Text("PLACE ORDER",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
