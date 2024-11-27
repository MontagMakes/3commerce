import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';

class DisplayProductsHome extends StatelessWidget {
  const DisplayProductsHome({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.count(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(
              products.length,
              (index) {
                return InkWell(
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                productDetails: products[index],
                              ),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(products[index].imageUrl),
                            height: 120,
                            width: 130,
                          ),
                          Text(
                            products[index].title,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 7.0, right: 7.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${products[index].price.toString()}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                const SizedBox(width: 70),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
