import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartButtonProductDetails extends StatelessWidget {
  const AddToCartButtonProductDetails({
    super.key,
    required this.productDetails,
  });
  final ProductModel productDetails;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
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
            Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
