import 'package:e_commerce/globals.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/screens/main_screen/main_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpFormBtn extends StatelessWidget {
  const SignUpFormBtn({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.updateLoadingState,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _nameController = nameController;

  final Function(bool) updateLoadingState;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              updateLoadingState(true);
              try {
                await userProvider.signUp(_emailController.text,
                    _passwordController.text, _nameController.text);

                await productProvider
                    .fetchProductData(userProvider.getUserId());
                await orderProvider.fetchOrders(userProvider.getUserId());
                Navigator.pushAndRemoveUntil(
                    Globals.scaffoldKey.currentContext!,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false);
                updateLoadingState(false);
              } on FirebaseAuthException catch (e) {
                logger.e(e);
                Utils.showToast(e.code);
                updateLoadingState(false);
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
        ));
  }
}
