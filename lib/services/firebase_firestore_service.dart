import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/model_order.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:e_commerce/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel? user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.id)
          .set(user.toMap());
    } catch (e) {
      logger.e(e);
    }
  }

  Future<UserModel> fetchUserData(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<List<ProductModel>> fetchProductData() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Error fetching Products: $e');
      rethrow;
    }
  }

  Future<List<OrderModel>> fetchOrderData() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('orders').get();
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Error fetching Orders: $e');
      throw Exception('Error fetching Orders: $e');
    }
  }

  Future<String> addProduct(ProductModel product) async {
    DocumentReference docRef =
        await _firestore.collection('products').add(product.toMap());
    String productId = docRef.id;

    await docRef.update({'id': productId});
    return productId;
  }

  Future<String> addOrder(OrderModel order) async {
    DocumentReference docRef =
        await _firestore.collection('orders').add(order.toMap());
    String orderId = docRef.id;

    await docRef.update({'id': orderId});
    return orderId;
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }
}
