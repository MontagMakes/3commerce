import 'package:e_commerce/models/model_product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderFavourites with ChangeNotifier {
  List<ProductModel> _items = [];

  List<ProductModel> get items => [..._items];

  List<ProductModel> get itemsList {
    return _items;
  }

  void addItem(ProductModel product) {
    if (!_items.contains(product)) {
      _items.add(product);
      Fluttertoast.showToast(msg: "Item added to favorites.");
    } else {
      Fluttertoast.showToast(msg: "Item is already in your favorites.");
    }

    notifyListeners();
  }

  void removeItem(ProductModel product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearFavourites() {
    _items = [];
    notifyListeners();
  }
}
