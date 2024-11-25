
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormCreateProduct extends StatelessWidget {
  const PriceFormCreateProduct({
    super.key,
    required TextEditingController priceController,
  }) : _priceController = priceController;

  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _priceController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
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


