import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_form/widgets/sign_up_form_btn.dart';
import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_form/widgets/sign_up_form_confirm_password.dart';
import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_form/widgets/sign_up_form_email.dart';
import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_form/widgets/sign_up_form_name.dart';
import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_form/widgets/sign_up_form_password.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final Function(bool) updateLoadingState;
  const SignUpForm({super.key, required this.updateLoadingState});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 150),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),

              // SignUp label
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ]),
              const SizedBox(height: 20),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Name field
                    SignUpFormName(nameController: _nameController),
                    const SizedBox(height: 20),

                    // Email Field
                    SignUpFormEmail(emailController: _emailController),
                    const SizedBox(height: 20),

                    // Password Field
                    SignUpFormPassword(passwordController: _passwordController),
                    const SizedBox(height: 20),

                    // Confirm Password Field
                    SignUpFormConfirmPassword(
                        passwordController: _passwordController),
                    const SizedBox(height: 30),

                    // SignUp button
                    SignUpFormBtn(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      updateLoadingState: widget.updateLoadingState,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
