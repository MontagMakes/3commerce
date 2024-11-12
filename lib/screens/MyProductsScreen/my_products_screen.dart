import 'package:e_commerce/providers/provider_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProviderProduct>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: const Text("MyProducts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/createProduct');
        },
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.add),
      ),
      body: Container(
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

  Expanded _productsList(ProviderProduct productProvider) {
    return Expanded(
        child: ListView(
      children: List.generate(productProvider.myProducts.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/productDetails',
                arguments: productProvider.myProducts[index]);
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
                          onPressed: () {
                            productProvider.deleteProduct(
                                productProvider.myProducts[index].id);
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
