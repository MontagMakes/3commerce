
import 'package:flutter/material.dart';

class TitleFormCreateProduct extends StatelessWidget {
  const TitleFormCreateProduct({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the title';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Enter title',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
