import 'package:e_commerce/globals.dart';
import 'package:e_commerce/providers/provider_order.dart';
import 'package:e_commerce/providers/provider_product.dart';
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
    ProviderProduct providerProduct = Provider.of<ProviderProduct>(context);
    ProviderUser providerUser = Provider.of<ProviderUser>(context);
    ProviderOrder providerOrder = Provider.of<ProviderOrder>(context);

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
                await providerUser.signUp(_emailController.text,
                    _passwordController.text, _nameController.text);

                await providerProduct.fetchProductData();
                await providerOrder.fetchOrders();

                Navigator.pushReplacementNamed(
                  // ignore: use_build_context_synchronously
                  Globals.scaffoldKey.currentContext!,
                  "/main",
                );

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
