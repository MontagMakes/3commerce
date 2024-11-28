
import 'package:e_commerce/globals.dart';
import 'package:flutter/material.dart';

class CategoryFormEditProduct extends StatelessWidget {
  const CategoryFormEditProduct({super.key, required this.selectedOption, required this.selectNewOption});
  final Function(String) selectNewOption;
  final String? selectedOption;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: Globals.categories.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? value) => selectNewOption(value!),
      value: selectedOption,
      decoration: const InputDecoration(labelText: 'Select Category'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }
}
