import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/main_screen/main_screen.dart';
import 'package:e_commerce/screens/model_view_screen/model_view_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productDetails,
  });

  final ProductModel productDetails;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Container(
            decoration: BoxDecoration(
              gradient: Utils.appBarGradient,
            ),
            child: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const MainScreen();
                  }));
                },
              ),
              title: const Text("Product Details"),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Image(
                    image: NetworkImage(productDetails.imageUrl),
                    fit: BoxFit.contain,
                  )),

              // Add a container with title, 3D button, price
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Product title
                        SizedBox(
                          width: 100,
                          child: Text(
                            productDetails.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // 3D button
                        Container(
                          decoration: BoxDecoration(
                            gradient: productDetails.modelUrl == ''
                                ? null
                                : Utils.appBarGradient,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ElevatedButton(
                            onPressed: productDetails.modelUrl == ''
                                ? null
                                : () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ModelViewScreen(
                                        productDetails: productDetails,
                                      );
                                    }));
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: const Text(
                              "3D",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        // Product price
                        Text(
                          "\$${productDetails.price}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Product category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Category: ${productDetails.category}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Product description
                    Text(
                      productDetails.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Add to cart button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartProvider.addItem(productDetails);
                            Utils.showToast('Product added to cart');
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: Utils.appBarGradient,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.shopping_cart_outlined,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
