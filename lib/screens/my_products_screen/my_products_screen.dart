import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/create_product_screen.dart/create_product_screen.dart';
import 'package:e_commerce/screens/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  bool _isLoading = false;

  void isLoading(bool value) {
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
                      : _productsList(productProvider)
                ],
              ),
            ),
    );
  }

  Expanded _productsList(ProductProvider productProvider) {
    return Expanded(
        child: ListView(
      children: List.generate(productProvider.myProducts.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                        productDetails: productProvider.myProducts[index])));
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    constraints:
                        const BoxConstraints(maxHeight: 100, maxWidth: 100),
                    child: Image(
                        image: NetworkImage(
                            productProvider.myProducts[index].imageUrl))),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productProvider.myProducts[index].title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('\$${productProvider.myProducts[index].price}',
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () async {
                            isLoading(true);
                            await productProvider.deleteProduct(
                                productProvider.myProducts[index].id);
                            isLoading(false);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
