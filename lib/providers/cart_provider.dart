import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final CartModel _cart = CartModel(products: [], totalAmount: 0);

  CartModel get cart => _cart;

  int get totalAmount {
    var total = 0;
    for (var item in cart.products) {
      total += item.price;
    }
    return total;
  }

  void addItem(ProductModel product) {
    _cart.products.add(product);
    notifyListeners();
  }

  void removeItem(ProductModel product) {
    _cart.products.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.products = [];
    notifyListeners();
  }
}
