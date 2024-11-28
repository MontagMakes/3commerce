import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/my_products_screen/widgets/list_my_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  bool _isLoading = false;

  void updateLoadingState(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("MyProducts"),
      ),
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  productProvider.myProducts.isEmpty
                      ? const Center(
                          heightFactor: 30,
                          child: Text("List is empty"),
                        )
                      : ListMyProducts(
                          updateLoadingState: updateLoadingState)
                ],
              ),
            ),
    );
  }
}
