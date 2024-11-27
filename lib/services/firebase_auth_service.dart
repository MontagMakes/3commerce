import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService with ChangeNotifier {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  // Get the current user's uid
  String getUserId() {
    final User? user = _authInstance.currentUser;
    final String uid = user!.uid;
    return uid;
  }

  // Sign In with email and password
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

  // SingUp with email, password and name
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

  // signOut
  Future<void> signOut() async {
    await _authInstance.signOut();
    notifyListeners();
  }

  // Reset Password with email
  Future<void> resetPassword(String email) async {
    try {
      await _authInstance.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }
}
