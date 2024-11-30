import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final CartModel _cart = CartModel(products: [], totalPrice: 0);

  CartModel get cart => _cart;

  void addItem(ProductModel product) {
    _cart.products.add(product);
    _cart.totalPrice += product.price;
    notifyListeners();
  }

  void removeItem(ProductModel product) {
    _cart.products.remove(product);
    _cart.totalPrice -= product.price;
    notifyListeners();
  }

  void clearCart() {
    _cart.products = [];
    _cart.totalPrice = 0;
    notifyListeners();
  }
}
