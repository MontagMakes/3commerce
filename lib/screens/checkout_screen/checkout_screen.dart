import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/screens/checkout_screen/widgets/checkout_Form_address.dart';
import 'package:e_commerce/screens/checkout_screen/widgets/checkout_form_button.dart';
import 'package:e_commerce/screens/checkout_screen/widgets/checkout_form_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.grey)),
      ),
      body: const Padding(
          padding: EdgeInsets.only(left: 16.0), child: CheckoutForm()),
    );
  }
}

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
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
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const Text("shipping address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Shipping Address
          CheckoutFormAddress(
              countryController: countryController,
              cityController: cityController,
              streetController: streetController),
          const SizedBox(height: 20),

          // Payment Method
          const Text("Payment method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Credit Card
          const Text("Credit Card"),
          const CheckoutFormPayment(),
          const SizedBox(height: 20),
          const Text("TOTAL AMOUNT", style: TextStyle(color: Colors.grey)),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) => Text(
                "\$${cartProvider.totalAmount}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),

          // Checkout Button
          CheckoutFormButton(
              formKey: _formKey,
              countryController: countryController,
              cityController: cityController,
              streetController: streetController),
        ],
      ),
    );
  }
}
