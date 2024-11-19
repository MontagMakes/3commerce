import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/provider_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BtnFormFieldSignUp extends StatelessWidget {
  const BtnFormFieldSignUp({
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
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
            String message = "";

            if (_formKey.currentState!.validate()) {
              updateLoadingState(true);
              try {
                await userProvider.signUp(_emailController.text,
                    _passwordController.text, _nameController.text);

                await productProvider.fetchProductData();
                await orderProvider.fetchOrders();
                // Navigator.push(
                //     Globals.scaffoldKey.currentContext!,
                //     MaterialPageRoute(
                //       builder: (context) => const MainScreen(),
                //     ));
                updateLoadingState(false);
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
