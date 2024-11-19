import 'package:e_commerce/screens/sign_in_screen/widgets/sign_In_widget.dart';
import 'package:e_commerce/screens/sign_in_screen/widgets/sign_in_get_started_button.dart';
import 'package:e_commerce/screens/sign_in_screen/widgets/sign_in_btn.dart';
import 'package:e_commerce/screens/sign_in_screen/widgets/sign_in_title.dart';
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
            // SignIn Logo and Title
            SignInTitle(animation: _animation),

            // SignIn Get Started Button
            const SignInGetStartedBtn(),
            const SizedBox(height: 20),

            const Positioned(
                left: 0, right: 0, bottom: 10, child: SignInWidget()),
            // SignIn Button
            // SignInBtn(controller: _controller),
          ],
        ),
      ),
    );
  }
}
