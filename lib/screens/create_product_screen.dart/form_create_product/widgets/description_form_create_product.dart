import 'package:flutter/material.dart';

class DescriptionFormCreateProduct extends StatelessWidget {
  const DescriptionFormCreateProduct({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _descriptionController,
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