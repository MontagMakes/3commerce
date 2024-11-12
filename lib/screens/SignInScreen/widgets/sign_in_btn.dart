import 'package:e_commerce/screens/SignInScreen/widgets/sign_in_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SignInBtn extends StatelessWidget {
  const SignInBtn({super.key, required this.controller});

  final AnimationController controller;

  // function to open signInSheet using the animation controller
  void _showSignInSheet(context) {
    controller.forward();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SignInBottomSheet(),
    ).then((_) => controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 150,
      child: Center(
        child: TextButton(
          onPressed: () => _showSignInSheet(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text('SIGN IN'),
        ),
      ),
    );
  }
}
