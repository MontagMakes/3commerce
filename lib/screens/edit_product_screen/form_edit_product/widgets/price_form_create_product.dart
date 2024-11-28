import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormEditProduct extends StatelessWidget {
  const PriceFormEditProduct(
      {super.key, required this.priceController, required this.price});

  final TextEditingController priceController;
  final int price;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: price.toString(),
      controller: priceController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Enter the Price',
      ),
    );
  }
}
