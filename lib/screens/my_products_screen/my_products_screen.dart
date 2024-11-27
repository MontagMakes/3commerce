import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/create_product_screen.dart/create_product_screen.dart';
import 'package:e_commerce/screens/my_products_screen/widgets/products_my_products.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateProductScreen();
          }));
        },
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add),
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
                      : ProductsMyProducts(
                          updateLoadingState: updateLoadingState)
                ],
              ),
            ),
    );
  }
}
