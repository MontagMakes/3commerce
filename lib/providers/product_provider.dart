import 'dart:io';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:e_commerce/services/firebase_storage_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();
  final FirebaseStorageService _storageService = FirebaseStorageService();

  UserProvider? _userProvider;

  List<ProductModel> _totalProducts = [];
  List<ProductModel> _myProducts = [];

  List<ProductModel> get totalProducts => [..._totalProducts];
  List<ProductModel> get myProducts => [..._myProducts];

  // Get UserProvider (in order to use userId
  void updateUserProvider(UserProvider userProvider) {
    _userProvider = userProvider;
    notifyListeners();
  }

  // Add product to FirebaseFirestore and FirebaseStorage
  Future<void> createProduct(String title, String description, int price,
      String category, File imageFile, File? modelFile) async {
    // Upload image and model files to FirebaseStorage
    String imageUrl = await _storageService.uploadImageFile(imageFile);
    String modelUrl;
    modelFile != null
        ? modelUrl = await _storageService.uploadModelFile(modelFile)
        : modelUrl = '';

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

    String productId = await _fireStoreService.createProduct(product);

    product = product.copyWith(id: productId);

    // _totalProducts.add(product);
    _myProducts.add(product);
    notifyListeners();
  }

  // Add product to FirebaseFirestore and FirebaseStorage
  Future<void> editProduct(String title, String description, int price,
      String category, File? imageFile, File? modelFile,
      [String? oldImageUrl, String? oldModelUrl]) async {
    String imageUrl;
    String modelUrl;

    // if oldImage is not changed then use the oldImageUrl
    // else delete the old image and upload the new image and save its url
    if (oldImageUrl != null) {
      imageUrl = oldImageUrl;
    } else {
      await _storageService.deleteFile(oldImageUrl!);
      imageUrl = await _storageService.uploadImageFile(imageFile!);
    }

    // if oldModel is not changed then use the oldModel
    // else delete the old Model and upload the new model and save its url
    if (oldModelUrl != null) {
      modelUrl = oldModelUrl;
    } else {
      await _storageService.deleteFile(oldModelUrl!);
      modelUrl = modelFile != null
          ? await _storageService.uploadModelFile(modelFile)
          : '';
    }

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

    String productId = await _fireStoreService.createProduct(product);

    product = product.copyWith(id: productId);

    _totalProducts.add(product);
    _myProducts.add(product);
    notifyListeners();
  }

  // Fetch product data from FirebaseFirestore
  Future<void> fetchProductData(String currentUserID) async {
    try {
      List<ProductModel> fetchedProductData =
          await _fireStoreService.fetchProductData();

      _totalProducts = fetchedProductData
          .where((element) =>
              element.ownerID != currentUserID)
          .toList();
           
      _myProducts = fetchedProductData
          .where((element) =>
              element.ownerID == currentUserID)
          .toList();

      notifyListeners();
    } catch (e) {
      logger.e('Error fetching Products: $e');
      rethrow;
    }
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
