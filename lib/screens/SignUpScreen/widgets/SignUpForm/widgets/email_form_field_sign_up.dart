import 'package:flutter/material.dart';

class EmailFormFieldSignUp extends StatelessWidget {
  const EmailFormFieldSignUp({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        } else if (!value.contains('@')) {
          return 'Please enter a valid email';
        } else if (!value.contains('.')) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Enter Email',
        hintText: 'AbdulRehman@gmail.com',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
