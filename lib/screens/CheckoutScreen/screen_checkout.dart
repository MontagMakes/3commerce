import 'package:e_commerce/globals.dart';
import 'package:e_commerce/providers/provider_cart.dart';
import 'package:e_commerce/providers/provider_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenCheckout extends StatefulWidget {
  const ScreenCheckout({super.key});

  @override
  State<ScreenCheckout> createState() => _ScreenCheckoutState();
}

class _ScreenCheckoutState extends State<ScreenCheckout> {
  bool isLoading = false;

  void updateLoadingState(bool newIsloading) {
    setState(() {
      isLoading = newIsloading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ProviderCart>(context);
    final orderProvider = Provider.of<ProviderOrder>(context);

    TextEditingController countryController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController streetController = TextEditingController();

    final GlobalKey<FormState> checkoutFormKey = GlobalKey<FormState>();

    return Scaffold(
      key: Globals.scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Form(
                key: checkoutFormKey,
                child: ListView(
                  children: [
                    const Text("shipping address",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: countryController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Country',
                              hintText: 'UK',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextFormField(
                            controller: cityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'city',
                              hintText: 'london',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextFormField(
                            controller: streetController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Street Address',
                              hintText: '123 Main St',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Payment method",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Credit Card"),
                    Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name on Card',
                            hintText: 'Joe Doe',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Card Number',
                            hintText: '1234 5678 9012 3456',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            hintText: '01/04/23',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("TOTAL AMOUNT",
                        style: TextStyle(color: Colors.grey)),
                    Text("\$${cartProvider.totalAmount}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        if (checkoutFormKey.currentState!.validate()) {
                          updateLoadingState(true);
                          String address =
                              '${streetController.text},${cityController.text},${countryController.text}';
                          await orderProvider.addOrder(cartProvider.items,
                              cartProvider.totalAmount, address);
                          cartProvider.clearCart();
                          updateLoadingState(false);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("PLACE ORDER",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
