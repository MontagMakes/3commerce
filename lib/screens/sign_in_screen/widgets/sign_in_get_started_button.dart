import 'package:e_commerce/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInGetStartedBtn extends StatelessWidget {
  const SignInGetStartedBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 200,
      child: Center(
        child: ElevatedButton(
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SignUpScreen();
          })),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFFF4081),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text('GET STARTED'),
        ),
      ),
    );
  }
}
