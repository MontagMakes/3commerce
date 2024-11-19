import 'dart:io';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:e_commerce/services/firebase_storage_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();

  UserProvider? _userProvider;

  List<ProductModel> _totalProducts = [];
  List<ProductModel> _myProducts = [];

  List<ProductModel> get totalProducts => [..._totalProducts];
  List<ProductModel> get myProducts => [..._myProducts];

  // Get UserProvider
  void updateUserProvider(UserProvider userProvider) {
    _userProvider = userProvider;
    notifyListeners();
  }
  
  Future<void> fetchProductData() async {
    try {
      _totalProducts = await _fireStoreService.fetchProductData();
      _myProducts = _totalProducts
          .where((element) =>
              element.ownerID == _userProvider!.getUserId().toString())
          .toList();
      notifyListeners();
    } catch (e) {
      logger.e('Error fetching Products: $e');
      rethrow;
    }
  }

  // Add product to FirebaseFirestore and FirebaseStorage
  Future<void> addProduct(String title, String description, int price, String category,
      File imageFile, File modelFile) async {
    // Upload image and model files to FirebaseStorage
    var imageUrl = await _storageService.uploadImageFile(imageFile);
    var modelUrl = await _storageService.uploadModelFile(modelFile);

    // Create ProductModel object
    ProductModel product = ProductModel(
        id: '',
        title: title,
        description: description,
        price: price,
        category: category,
        ownerID: _userProvider!.getUserId().toString(),
        imageUrl: imageUrl,
        modelUrl: modelUrl);

    String productId = await _fireStoreService.addProduct(product);

    product = product.copyWith(id: productId);

    _totalProducts.add(product);
    _myProducts.add(product);
    notifyListeners();
  }

  // Delete product from FirebaseFirestore and FirebaseStorage
  Future<void> deleteProduct(String productId) async {
    try {
      // Delete product image from FirebaseStorage
      await _storageService.deleteFile(_myProducts
          .firstWhere((element) => element.id == productId)
          .imageUrl);

      // Delete product 3Dmodel from FirebaseStorage
      await _storageService.deleteFile(_myProducts
          .firstWhere((element) => element.id == productId)
          .modelUrl);

      // Delete product from FirebaseFirestore
      await _fireStoreService.deleteProduct(productId);

      // Delete product from _myProducts and _totalProducts Lists
      _myProducts.removeWhere((element) => element.id == productId);
      _totalProducts.removeWhere((element) => element.id == productId);

      notifyListeners();
    } catch (e) {
      logger.e('Error deleting product: $e');
      rethrow;
    }
  }
}
