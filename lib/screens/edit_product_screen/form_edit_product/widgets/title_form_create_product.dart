import 'package:flutter/material.dart';

class TitleFormEditProduct extends StatelessWidget {
  final String title;
  final TextEditingController titleController;
  const TitleFormEditProduct(
      {super.key, required this.titleController, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      initialValue: title,
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
