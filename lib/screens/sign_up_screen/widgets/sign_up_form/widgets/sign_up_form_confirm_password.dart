import 'package:flutter/material.dart';

class SignUpFormConfirmPassword extends StatefulWidget {
  const SignUpFormConfirmPassword({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  State<SignUpFormConfirmPassword> createState() =>
      _SignUpFormConfirmPasswordState();
}

class _SignUpFormConfirmPasswordState
    extends State<SignUpFormConfirmPassword> {
  bool _isPasswordVisible = false;

  void isPasswordVisible() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password again';
        } else if (value != widget._passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
