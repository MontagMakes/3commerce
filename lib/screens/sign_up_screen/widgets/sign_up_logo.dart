import 'package:flutter/material.dart';

class SignUpLogo extends StatefulWidget {
  const SignUpLogo({
    super.key,
  });

  @override
  State<SignUpLogo> createState() => _SignUpLogoState();
}

class _SignUpLogoState extends State<SignUpLogo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                '3C',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
