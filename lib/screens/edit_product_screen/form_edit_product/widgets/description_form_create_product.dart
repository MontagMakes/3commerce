import 'package:flutter/material.dart';

class DescriptionFormEditProduct extends StatelessWidget {
  const DescriptionFormEditProduct(
      {super.key,
      required this.descriptionController,
      required this.description});

  final String description;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: description,
      controller: descriptionController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the description';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Enter Description',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
