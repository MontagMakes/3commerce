import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/edit_product_screen/edit_product_screen.dart';
import 'package:e_commerce/screens/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMyProducts extends StatelessWidget {
  final Function(bool) updateLoadingState;
  const ListMyProducts({super.key, required this.updateLoadingState});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
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
                // Product image
                Container(
                    constraints:
                        const BoxConstraints(maxHeight: 100, maxWidth: 100),
                    child: Image(
                        image: NetworkImage(
                            productProvider.myProducts[index].imageUrl))),
                const SizedBox(width: 16),

                // Product title, price, delete button
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              ProductModel product = productProvider.myProducts
                                  .firstWhere((element) =>
                                      element.id ==
                                      productProvider.myProducts[index].id);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditProductScreen(
                                  product: product,
                                );
                              }));
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () async {
                              updateLoadingState(true);
                              await productProvider.deleteProduct(
                                  productProvider.myProducts[index].id);
                              updateLoadingState(false);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
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
