import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> _items = [];
  final int _quantity = 0;

  List<ProductModel> get items => [..._items];
  int get quantity => _quantity;

  double get totalAmount {
    var total = 0.0;
    for (var item in _items) {
      total += item.price;
    }
    return total;
  }

  List<ProductModel> get itemsList {
    return _items;
  }

  void addItem(ProductModel product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(ProductModel product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }

  int getCartLength(){
    return _items.length;}
}
