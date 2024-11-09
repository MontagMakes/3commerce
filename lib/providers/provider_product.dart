import 'package:e_commerce/models/model_product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderProduct with ChangeNotifier {
  List<ProductModel> _totalProducts = [];

  List<ProductModel> get totalProducts => [..._totalProducts];

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      _totalProducts = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data() as String))
          .toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void addProduct(ProductModel product) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .add(product.toJson() as Map<String, dynamic>);
      _totalProducts.add(product);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  ProductModel findById(String id) {
    // ignore: unrelated_type_equality_checks
    return _totalProducts.firstWhere((prod) => prod.id == id);
  }
}
