import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/screens/main_screen/main_screen.dart';
import 'package:e_commerce/screens/product_details_screen/widgets/add_to_cart_button_product_details.dart';
import 'package:e_commerce/screens/product_details_screen/widgets/model_button_product_details.dart';
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
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) {
                return const MainScreen();
              }));
            },
          ),
          title: const Text("Product Details"),
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
                        ModelButtonProductDetails(
                            productDetails: productDetails),

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

                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          productDetails.ownerID != userProvider.getUserId()
                              ? AddToCartButtonProductDetails(
                                  productDetails: productDetails)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
