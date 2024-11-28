import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/firebase_auth_service.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  List<OrderModel> _orders = [];

  List<String> status = ['Pending', 'Delivered', 'Cancelled'];

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
      status: status[0],
    );

    String orderId = await _fireStoreService.createOrder(order);
    order = order.copyWith(id: orderId);

    _orders.add(order);
    notifyListeners();
  }

  // Fetch Orders
  Future<void> fetchOrders(currentUserID) async {
    try {
      _orders = await _fireStoreService.fetchOrderData().then((orders){
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
      await _fireStoreService.deleteOrder(orderId);
      _orders.removeWhere((element) => element.id == orderId);

      notifyListeners();
    } catch (e) {
      logger.e('Error deleting Order: $e');
      rethrow;
    }
  }
}
