import 'package:e_commerce/globals.dart';
import 'package:e_commerce/screens/checkout_screen/form_checkout/form_checkout.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController streetController = TextEditingController();

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
        key: Globals.scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Checkout", style: TextStyle(color: Colors.grey)),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FormCheckout(updateLoadingState: updateLoadingState));
  }
}
