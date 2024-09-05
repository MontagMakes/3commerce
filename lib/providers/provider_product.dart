import 'package:e_commerce/data/data.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderProduct with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => [..._products];

  List<ProductModel> getAllProducts(){
    _products = ProductData().products;
    return _products;
  }
  
  Future<void> getProductFromApi() async {
    // _products = await ApiManager().getProducts();
    if (_products.isEmpty) _products.addAll(_products);

  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      _products = snapshot.docs
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
      _products.add(product);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  ProductModel findById(String id) {
    // ignore: unrelated_type_equality_checks
    return _products.firstWhere((prod) => prod.id == id);
  }
}
