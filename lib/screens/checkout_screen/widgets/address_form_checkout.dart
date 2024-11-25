import 'package:flutter/material.dart';

class AddressFormCheckout extends StatelessWidget {
  const AddressFormCheckout({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Shipping address",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

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
