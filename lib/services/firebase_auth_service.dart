import 'package:e_commerce/models/model_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService with ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authStateChanges (){
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // await _fetchUserData(userCredential.user?.uid);
      notifyListeners();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _currentUser = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(_currentUser!.toMap());
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _fetchUserData(String? uid) async {
    if (uid == null) return;
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      _currentUser = UserModel.fromMap(doc.data() as Map<String, dynamic>);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }
}
