import 'package:e_commerce/providers/provider_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                SizedBox(
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
                ),

                // SignUp Form
                Container(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 30),

                          // SignUp label
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                TextFormField(
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Enter name',
                                    hintText: 'muhammed',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Email Field
                                TextFormField(
                                  controller: _emailController,
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
                                  decoration: const InputDecoration(
                                    labelText: 'Enter Email',
                                    hintText: 'AbdulRehman@gmail.com',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Password Field
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    } else if (!value
                                        .contains(RegExp(r'[A-Z]'))) {
                                      return 'Password must contain at least one uppercase letter';
                                    } else if (!value
                                        .contains(RegExp(r'[0-9]'))) {
                                      return 'Password must contain at least one number';
                                    }
                                    return null;
                                  },
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Confirm Password Field
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password again';
                                    } else if (value !=
                                        _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  obscureText: !_isPasswordVisible,
                                  decoration: const InputDecoration(
                                    labelText: 'Confirm Password',
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // SignUp button
                                Consumer<ProviderUser>(
                                  builder: (context, auth, child) => SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          String message = "";

                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            try {
                                              await auth.signUp(
                                                  _emailController.text,
                                                  _passwordController.text,
                                                  _nameController.text);

                                              Navigator.pushNamedAndRemoveUntil(
                                                // ignore: use_build_context_synchronously
                                                context,
                                                "/main",
                                                (route) => false,
                                              );

                                              setState(() {
                                                _isLoading = false;
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              message = e.code;
                                              Fluttertoast.showToast(
                                                msg: message,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                fontSize: 16.0,
                                              );
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'SignUp',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
