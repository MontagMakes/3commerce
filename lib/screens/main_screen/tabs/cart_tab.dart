import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/checkout_screen/checkout_screen.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _cartList(cartProvider),
          _totalAmount(cartProvider.totalAmount),
          _checkoutButton(context, cartProvider),
        ],
      ),
    );
  }

  Expanded _cartList(CartProvider cartProvider) {
    return Expanded(
        child: ListView(
      children: List.generate(cartProvider.items.length, (index) {
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
                      cartProvider.items[index].imageUrl,
                    ),
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartProvider.items[index].title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('\$${cartProvider.itemsList[index].price}',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          cartProvider.removeItem(cartProvider.items[index]);
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

  Container _totalAmount(double totalAmount) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TOTAL AMOUNT',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$$totalAmount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Container _checkoutButton(context, cartprovider) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (cartprovider.getCartLength() == 0) {
            Fluttertoast.showToast(
              msg: "Your cart is empty. Please add items to proceed.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CheckoutScreen()));
          }
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CHECKOUT',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
