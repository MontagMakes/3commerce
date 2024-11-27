import 'package:e_commerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCart extends StatelessWidget {
  const ListCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Expanded(
        child: ListView(
      children: List.generate(cartProvider.cart.products.length, (index) {
        return Container(
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
                      cartProvider.cart.products[index].imageUrl,
                    ),
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartProvider.cart.products[index].title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('\$${cartProvider.cart.products[index].price}',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          cartProvider
                              .removeItem(cartProvider.cart.products[index]);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
