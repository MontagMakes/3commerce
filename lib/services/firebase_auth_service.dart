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

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // await _fetchUserData(userCredential.user?.uid);
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

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }
}
