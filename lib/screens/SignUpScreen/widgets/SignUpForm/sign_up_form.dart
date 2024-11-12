import 'package:e_commerce/screens/SignUpScreen/widgets/SignUpForm/widgets/btn_form_field_sign_up.dart';
import 'package:e_commerce/screens/SignUpScreen/widgets/SignUpForm/widgets/confirm_password_form_field_sign_up.dart';
import 'package:e_commerce/screens/SignUpScreen/widgets/SignUpForm/widgets/email_form_field_sign_up.dart';
import 'package:e_commerce/screens/SignUpScreen/widgets/SignUpForm/widgets/name_form_field_sign_up.dart';
import 'package:e_commerce/screens/SignUpScreen/widgets/SignUpForm/widgets/password_form_field_sign_up.dart';
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
                    NameFormFieldSignUp(nameController: _nameController),
                    const SizedBox(height: 20),

                    // Email Field
                    EmailFormFieldSignUp(emailController: _emailController),
                    const SizedBox(height: 20),

                    // Password Field
                    PasswordFormFieldSignUp(
                        passwordController: _passwordController),
                    const SizedBox(height: 20),

                    // Confirm Password Field
                    ConfirmPasswordFormFieldSignUp(
                        passwordController: _passwordController),
                    const SizedBox(height: 30),

                    // SignUp button
                    BtnFormFieldSignUp(
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
