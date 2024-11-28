import 'package:e_commerce/globals.dart';
import 'package:e_commerce/screens/create_product_screen/form_create_product/form_create_product.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  bool _isLoading = false;


  void updateLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Product'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : FormCreateProduct(
              updateLoadingState: updateLoadingState),
    );
  }
}
