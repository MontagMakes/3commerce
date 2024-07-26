import 'package:flutter/material.dart';

class AnimatedSignInScreen extends StatefulWidget {
  const AnimatedSignInScreen({super.key});

  @override
  _AnimatedSignInScreenState createState() => _AnimatedSignInScreenState();
}

class _AnimatedSignInScreenState extends State<AnimatedSignInScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF4081), Color(0xFFFF7043)],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
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
                              'R',
                              style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'RAMNI',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Center(
                child: ElevatedButton(
                  onPressed: _showSignInSheet,
                  child: const Text('SIGN IN'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFF4081),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInBottomSheet extends StatelessWidget {
  const SignInBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('SIGN IN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF4081))),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'User Name',
                hintText: 'pankaj_patel',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('SIGN IN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4081),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot password?', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}