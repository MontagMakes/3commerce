import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:e_commerce/providers/provider_user.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:e_commerce/services/firebase_storage_service.dart';
import 'package:flutter/material.dart';

class ProviderProduct with ChangeNotifier {
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();

  ProviderUser? _providerUser;

  List<ProductModel> _totalProducts = [];
  List<ProductModel> _myProducts = [];

  List<ProductModel> get totalProducts => [..._totalProducts];
  List<ProductModel> get myProducts => [..._myProducts];

  // Get ProviderUser
  void updateProviderUser(ProviderUser providerUser) {
    _providerUser = providerUser;
    notifyListeners();
  }

  // Future<void> fetchMyProducts() async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('products')
  //         .where('ownerID', isEqualTo: _providerUser!.getUserId().toString())
  //         .get();
  //     _myProducts = snapshot.docs
  //         .map(
  //             (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     logger.e('Error fetching my Products: $e');
  //     rethrow;
  //   }
  // }

  // Future<void> fetchTotalProducts() async {
  //   try {
  //     QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection('products').get();
  //     _totalProducts = snapshot.docs
  //         .map(
  //             (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //     fetchMyProducts();
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<void> fetchProductData() async {
    try {
      if (_providerUser == null) {
        throw Exception('ProviderUser is not set');
      }

      final userId = _providerUser?.getUserId();
      if (userId == null) {
        throw Exception('User ID is null');
      }
      _totalProducts = await _fireStoreService.fetchProductData();
      _myProducts = _totalProducts
          .where((element) =>
              element.ownerID == _providerUser!.getUserId().toString())
          .toList();
      notifyListeners();
    } catch (e) {
      logger.e('Error fetching Products: $e');
      rethrow;
    }
  }

  // Add product to FirebaseFirestore and FirebaseStorage
  Future<void> addProduct(String title, String description, int price,
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
        ownerID: _providerUser!.getUserId().toString(),
        imageUrl: imageUrl,
        modelUrl: modelUrl);

    String productId = await _fireStoreService.addProduct(product);

    product = product.copyWith(id: productId);

    _totalProducts.add(product);
    _myProducts.add(product);
    notifyListeners();
  }

  // Delete product from FirebaseFirestore and FirebaseStorage
  void deleteProduct(String productId) async {
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
