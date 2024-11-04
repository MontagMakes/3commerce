import 'package:e_commerce/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderAuth with ChangeNotifier {
  FirebaseAuthService authService = FirebaseAuthService();

  Future<void> signIn(String email, String password) async {
    await authService.signIn(email, password);
  }

  Stream<User?> authStateChanges() {
    return authService.authStateChanges();
  }

  Future<void> signUp(String email, String password, String name) async {
    return await authService.signUp(email, password, name);
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  Future<void> resetPassword (String email) async {
    await authService.resetPassword(email);
  }

}
