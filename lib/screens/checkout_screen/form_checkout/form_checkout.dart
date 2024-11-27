import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/checkout_screen/form_checkout/widgets/address_form_checkout.dart';
import 'package:e_commerce/screens/checkout_screen/form_checkout/widgets/button_form_checkout.dart';
import 'package:e_commerce/screens/checkout_screen/form_checkout/widgets/payment_form_checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormCheckout extends StatefulWidget {
  final Function(bool) updateLoadingState;
  const FormCheckout({super.key, required this.updateLoadingState});

  @override
  State<FormCheckout> createState() => _FormCheckoutState();
}

class _FormCheckoutState extends State<FormCheckout> {
  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController streetController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    cityController.dispose();
    countryController.dispose();
    streetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('BUTTON CHECKOUT BUILT');
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Amount Label
                  const Text("TOTAL AMOUNT",
                      style: TextStyle(color: Colors.grey)),

                  // Total Amount Value
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) => Text(
                        "\$${cartProvider.totalAmount}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Checkout Button
              ButtonFormCheckout(
                formKey: _formKey,
                streetController: streetController,
                cityController: cityController,
                countryController: countryController,
                updateLoadingState: widget.updateLoadingState,
              )
            ],
          ),
        ));
  }
}
