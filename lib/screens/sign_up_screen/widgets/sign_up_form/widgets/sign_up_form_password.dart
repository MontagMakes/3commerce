import 'package:flutter/material.dart';

class SignUpFormPassword extends StatefulWidget {
  final TextEditingController passwordController;
  const SignUpFormPassword({super.key, required this.passwordController});

  @override
  State<SignUpFormPassword> createState() =>
      _SignUpFormPasswordState();
}

class _SignUpFormPasswordState extends State<SignUpFormPassword> {
  bool _isPasswordVisible = false;

  void isPasswordVisibleToggle() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        } else if (!value.contains(RegExp(r'[A-Z]'))) {
          return 'Password must contain at least one uppercase letter';
        } else if (!value.contains(RegExp(r'[0-9]'))) {
          return 'Password must contain at least one number';
        }
        return null;
      },
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Enter Password',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            isPasswordVisibleToggle();
          },
        ),
      ),
    );
  }
}
