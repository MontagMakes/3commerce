import 'package:e_commerce/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> fetchUserData(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> saveUserData(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.id)
        .set(user.toJson() as Map<String, dynamic>);
  }

  Future<void> updateUserAvatar(String userId, String avatarUrl) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'avatarUrl': avatarUrl});
  }

  Future<void> addProductToWishlist(String userId, String productId) async {
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      'wishlist': FieldValue.arrayUnion([productId])
    });
  }
}
