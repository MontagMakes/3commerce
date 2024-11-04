import 'package:e_commerce/providers/provider_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignInBottomSheet extends StatefulWidget {
  const SignInBottomSheet({super.key});

  @override
  State<SignInBottomSheet> createState() => _SignInBottomSheetState();
}

class _SignInBottomSheetState extends State<SignInBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProviderUser>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

        // if the screen is loading, show loadingIndicator, else show the form
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // SignIn label
                    const Text('SIGN IN',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF4081))),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        } else if (!value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Password Field
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } else if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        } else if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one number';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // SignIn Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            await userProvider.signIn(
                                _emailController.text, _passwordController.text);
                            
                            Navigator.pushNamedAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              "/main",
                              (route) => false,
                            );
                          } on FirebaseAuthException catch (e) {
                            String message;
                            switch (e.code) {
                              case 'user-not-found':
                                message = 'No user found for that email.';
                                break;
                              case 'wrong-password':
                                message = 'Wrong password provided.';
                                break;
                              case 'invalid-email':
                                message = 'Invalid email provided.';
                                break;
                              default:
                                message = 'An error occurred. Please try again.';
                            }

                            Fluttertoast.showToast(
                                msg: "Login Failed: $message",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF4081),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('SIGN IN',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 10),

                    // ResetPassword button
                    TextButton(
                      onPressed: () async {
                        userProvider.resetPassword(_emailController.text);
                        Fluttertoast.showToast(
                          msg: "Password reset email sent",
                        );
                      },
                      child: const Text('Forgot password?',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}