import 'package:e_commerce/models/model_order.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderOrder with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => [..._orders];

  Future<void> fetchOrders(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();
      _orders = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data() as String))
          .toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void addOrder(
      List<ProductModel> cartProducts, double total, String userId) async {
    final newOrder = OrderModel(
      id: DateTime.now().toString(),
      products: cartProducts,
      totalAmount: total,
      orderDate: DateTime.now(),
      status: '',
    );
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': userId,
        'products':
            newOrder.products.map((product) => product.toJson()).toList(),
        'totalAmount': total,
        'orderDate': newOrder.orderDate.toIso8601String(),
      });
      _orders.add(newOrder);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
