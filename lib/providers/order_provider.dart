import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/firebase_auth_service.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:e_commerce/services/firebase_storage_service.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseStorageService _storageInstance = FirebaseStorageService();

  List<OrderModel> _orders = [];

  final List<String> _status = ['Pending', 'Delivered', 'Cancelled'];

  List<OrderModel> get orders => _orders;

  // Create Order
  Future<void> createOrder(
      List<ProductModel> cartProducts, int totalPrice, String address) async {
    String date = (DateTime.now().toString()).replaceRange(10, null, '');
    OrderModel order = OrderModel(
      id: '',
      products: cartProducts,
      address: address,
      totalPrice: totalPrice,
      orderDate: date,
      userId: _authService.getUserId(),
      status: _status[0],
    );

    String orderId = await _fireStoreService.createOrder(order);
    order = order.copyWith(id: orderId);

    _orders.add(order);
    notifyListeners();
  }

  // Fetch Orders
  Future<void> fetchOrders(currentUserID) async {
    try {
      _orders = await _fireStoreService.fetchOrderData().then((orders) {
        return orders.where((order) => order.userId == currentUserID).toList();
      });
      notifyListeners();
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }

  // Delete Order
  Future<void> deleteOrder(String orderId) async {
    try {
      // Check if the images in products are needed by products
      // If not, delete them from firebase Storage.
      OrderModel order = _orders.firstWhere((element) => element.id == orderId);

      // Check if the images in order are needed by products collection
      for (var product in order.products) {
        if (!await _fireStoreService.isImageNeededIn(
            product.imageUrl, 'products')) {
          _storageInstance.deleteFile(product.imageUrl);
        }
        if (!await _fireStoreService.isModelNeededIn(
            product.modelUrl, 'products')) {
          _storageInstance.deleteFile(product.modelUrl);
        }
      }

      await _fireStoreService.deleteOrder(orderId);
      _orders.removeWhere((element) => element.id == orderId);

      notifyListeners();
    } catch (e) {
      logger.e('Error deleting Order: $e');
      rethrow;
    }
  }
}
