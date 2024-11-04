import 'package:e_commerce/models/model_user.dart';
import 'package:e_commerce/services/firebase_auth_service.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderUser with ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();

  UserModel? _currentUserData;

  Stream<User?> get authStateChanges => _authService.authStateChanges();

  UserModel? get currentUserData => _currentUserData;

  // SignIn using email and password
  Future<void> signIn(String email, String password) async {
    UserCredential userCred = await _authService.signIn(email, password);
    await getUserData(userCred);
  }

  // SignOut
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUserData = null;
  }

  Future<void> signUp(String email, String password, String name) async {
    await _authService.signUp(email, password, name);
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getUserData(UserCredential userCred) async {
    _currentUserData =
        await _fireStoreService.fetchUserData(userCred.user!.uid);
  }

  String? getUserName() {
    return _currentUserData?.name;
  }

  String? getUserEmail() {
    return _currentUserData?.email;
  }
}
