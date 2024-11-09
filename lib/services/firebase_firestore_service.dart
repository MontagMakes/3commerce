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
      print(e);
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
}
