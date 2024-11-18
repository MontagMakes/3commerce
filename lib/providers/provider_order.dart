import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/model_order.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:e_commerce/services/firebase_auth_service.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:flutter/material.dart';

class ProviderOrder with ChangeNotifier {
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  List<OrderModel> _orders = [];

  List<String> status = ['Pending', 'Delivered', 'Cancelled'];

  List<OrderModel> get orders => _orders;

  // Fetch Orders
  Future<void> fetchOrders() async {
    try {
      _orders = await _fireStoreService.fetchOrderData();
      notifyListeners();
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }

  // Add Order
  Future<void> addOrder(List<ProductModel> cartProducts, double totalAmount,
      String address) async {
    String date = (DateTime.now().toString()).replaceRange(10, null, '');
    OrderModel order = OrderModel(
      id: '',
      products: cartProducts,
      address: address,
      totalAmount: totalAmount,
      orderDate: date,
      userId: _authService.getUserId(),
      status: status[0],
    );

    String orderId = await _fireStoreService.addOrder(order);
    order = order.copyWith(id: orderId);

    _orders.add(order);
    notifyListeners();
  }

  // Delete Order
  Future<void> deleteOrder(String orderId) async {
    try {
      await _fireStoreService.deleteOrder(orderId);
      _orders.removeWhere((element) => element.id == orderId);

      notifyListeners();
    } catch (e) {
      logger.e('Error deleting Order: $e');
      rethrow;
    }
  }

  // Update Order Status
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _fireStoreService.updateOrderStatus(orderId, status);
      _orders.firstWhere((element) => element.id == orderId).status = status;

      notifyListeners();
    } catch (e) {
      logger.e('Error updating Order Status: $e');
      rethrow;
    }
  }
}
