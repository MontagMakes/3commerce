import 'package:e_commerce/globals.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/edit_product_screen/form_edit_product/form_edit_product.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
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
        title: const Text('Edit Product'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : FormEditProduct(
              updateLoadingState: updateLoadingState, product: widget.product),
    );
  }
}
