import 'package:flutter/material.dart';

class CheckoutFormAddress extends StatelessWidget {
  const CheckoutFormAddress({
    super.key,
    required this.countryController,
    required this.cityController,
    required this.streetController,
  });

  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController streetController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Country
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
    
        // City
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
    
        // Street Address
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
    );
  }
}
