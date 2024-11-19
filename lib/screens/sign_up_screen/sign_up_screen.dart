import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_form/sign_up_form.dart';
import 'package:e_commerce/screens/sign_up_screen/widgets/sign_up_logo.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  bool _isLoading = false;

  void updateLoadingState(bool isloading) {
    setState(() {
      _isLoading = isloading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF4081), Color(0xFFFF7043)],
          ),
        ),

        // if the screen is loading, show loadingIndicator else show screen
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Stack(children: [
                // back button
                const SizedBox(
                    height: 150,
                    child: BackButton(
                      color: Colors.white,
                    )),

                // Logo
                const SignUpLogo(),

                // SignUp Form
                SignUpForm(updateLoadingState: updateLoadingState),
              ]),
      ),
    );
  }
}
