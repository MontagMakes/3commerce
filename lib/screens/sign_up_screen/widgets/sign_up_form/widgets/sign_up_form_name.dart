import 'package:flutter/material.dart';

class SignUpFormName extends StatelessWidget {
  const SignUpFormName({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Name';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Enter name',
        hintText: 'muhammed',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
