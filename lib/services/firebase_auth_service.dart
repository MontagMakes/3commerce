import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService with ChangeNotifier {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  String getUserId(){
    final User? user = _authInstance.currentUser;
    final String uid = user!.uid;
    return uid;
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      var userCred = await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);

      return userCred;
      // await _fetchUserData(userCredential.user?.uid);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential?> signUp(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _authInstance
          .createUserWithEmailAndPassword(email: email, password: password);

      notifyListeners();
      return userCredential;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authInstance.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }
}
