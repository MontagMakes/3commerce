import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProviderProduct with ChangeNotifier {
  // final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();

  List<ProductModel> _totalProducts = [];

  List<ProductModel> get totalProducts => [..._totalProducts];

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      _totalProducts = snapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // Future<void> fetchProducts () async {
  //   _totalProducts = await _fireStoreService.fetchProducts();
  // }

  Future<String> uploadImageFile(File imageFile) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}');

      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  Future<String> uploadModelFile(File modelFile) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('models/${DateTime.now()}');

      UploadTask uploadTask = ref.putFile(modelFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  void addProduct(String title, String description, int price, File imageFile,
      File modelFile) async {
    var imageUrl = await uploadImageFile(imageFile);
    var modelUrl = await uploadModelFile(modelFile);

    ProductModel product = ProductModel(
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
        modelUrl: modelUrl);

    await _fireStoreService.addProduct(product);
    _totalProducts.add(product);
    notifyListeners();
  }

  // ProductModel findById(String id) {
  //   // ignore: unrelated_type_equality_checks
  //   return _totalProducts.firstWhere((prod) => prod.id == id);
  // }
}
