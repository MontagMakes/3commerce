import 'package:e_commerce/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/user_model.dart';

class FirebaseFireStoreService {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  // Create a new user in Firestore using UserModel
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

  // Fetch user data from Firestore using userId and return it as UserModel
  Future<UserModel> fetchUserData(String userId) async {
    DocumentSnapshot doc =
        await _firestoreInstance.collection('users').doc(userId).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  // create a new product in Firestore using ProductModel
  Future<String> createProduct(ProductModel product) async {
    DocumentReference docRef =
        await _firestoreInstance.collection('products').add(product.toMap());
    String productId = docRef.id;

    await docRef.update({'id': productId});
    return productId;
  }

  // Fetch all Products from Firestore and return them as a list of ProductModel
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      QuerySnapshot snapshot =
          await _firestoreInstance.collection('products').get();
      return snapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Error fetching Products: $e');
      rethrow;
    }
  }

  // delete a product in Firestore using productId
  Future<void> deleteProduct(String productId) async {
    await _firestoreInstance.collection('products').doc(productId).delete();
  }

  // create a new order in Firestore using OrderModel
  Future<String> createOrder(OrderModel order) async {
    DocumentReference docRef =
        await _firestoreInstance.collection('orders').add(order.toMap());
    String orderId = docRef.id;

    await docRef.update({'id': orderId});
    return orderId;
  }

  // Fetch all orders from Firestore and return them as a list of OrderModel
  Future<List<OrderModel>> fetchOrderData() async {
    try {
      QuerySnapshot snapshot =
          await _firestoreInstance.collection('orders').get();
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Error fetching Orders: $e');
      throw Exception('Error fetching Orders: $e');
    }
  }

  // delete an order in Firestore using orderId
  Future<void> deleteOrder(String orderId) async {
    await _firestoreInstance.collection('orders').doc(orderId).delete();
  }

  // Check if the image is present in any order
  Future<bool> isImageNeededIn(String url, String neededIn) async {
    if (neededIn == 'orders') {
      return await _firestoreInstance
          .collection('orders')
          .where('products.imageUrl', isEqualTo: url)
          .get()
          .then((value) => value.docs.isNotEmpty);
    } else {
      return await _firestoreInstance
          .collection('products')
          .where('imageUrl', isEqualTo: url)
          .get()
          .then((value) => value.docs.isNotEmpty);
    }
  }

  // Check if the model is present in any order
  Future<bool> isModelNeededIn(String url, neededIn) async {
    if (neededIn == 'orders') {
      return await _firestoreInstance
          .collection('orders')
          .where('products.modelUrl', isEqualTo: url)
          .get()
          .then((value) => value.docs.isNotEmpty);
    } else {
      return await _firestoreInstance
          .collection('products')
          .where('modelUrl', isEqualTo: url)
          .get()
          .then((value) => value.docs.isNotEmpty);
    }
  }
}
