import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/model_product.dart';
import 'package:e_commerce/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<List<ProductModel>> fetchProducts() async {
  //   try {
  //     QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection('products').get();
  //     var totalProducts = snapshot.docs
  //         .map((doc) => ProductModel.fromJson(doc.data() as String))
  //         .toList();
  //     return totalProducts;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

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

  Future<void> addProductToWishlist(String userId, String productId) async {
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      'wishlist': FieldValue.arrayUnion([productId])
    });
  }

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').add(product.toMap());
  }
}
