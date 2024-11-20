import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/model_view_screen/model_view_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            decoration: Utils.appBarGradient,
            child: AppBar(
              
              title: const Text("Product Details"),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Add a container with image, title, 3D button, price
              Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Image(
                    image: NetworkImage(productDetails.imageUrl),
                    fit: BoxFit.contain,
                  )),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Add a row with title, rating, 3D button, price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Add a sized box with title
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
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF7080), Color(0xFFFF4081)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          productDetails.category,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Add to cart button
                        GestureDetector(
                          onTap: () {
                            cartProvider.addItem(productDetails);

                            Fluttertoast.showToast(
                              msg: "Product added to cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF7080), Color(0xFFFF4081)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
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
