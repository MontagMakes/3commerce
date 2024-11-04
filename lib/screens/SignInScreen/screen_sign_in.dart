import 'package:e_commerce/screens/SignInScreen/widgets/sign_in_bottom_sheet.dart';
import 'package:e_commerce/screens/SignUpScreen/screen_sign_up.dart';

import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // controller to control animation duration
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // controller to control the animation behavior
    _animation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // function to open signInSheet using the animation controller
  void _showSignInSheet() {
    _controller.forward();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SignInBottomSheet(),
    ).then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Page background color
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF4081), Color(0xFFFF7043)],
          ),
        ),

        // Using stack layout, to position the widgets
        child: Stack(
          children: [
            _title(),
            _getStartedButton(context),
            const SizedBox(height: 20),
            _signInButton(),
          ],
        ),
      ),
    );
  }

  AnimatedBuilder _title() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                ),
                const SizedBox(height: 20),
                const Text(
                  '3Commerce',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned _getStartedButton(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 200,
      child: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScreenSignUp())),
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

  Positioned _signInButton() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 150,
      child: Center(
        child: TextButton(
          onPressed: _showSignInSheet,
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
