import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/services/firebase_auth_service.dart';
import 'package:e_commerce/services/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuthService _authService;
  final FirebaseFireStoreService _fireStoreService;

  UserProvider()
      : _authService = FirebaseAuthService(),
        _fireStoreService = FirebaseFireStoreService();

  UserProvider.test({
    required FirebaseAuthService authService,
    required FirebaseFireStoreService fireStoreService,
  })  : _authService = authService,
        _fireStoreService = fireStoreService;

  UserModel? _currentUserData;
  UserModel? get currentUserData => _currentUserData;

  // SignIn using email and password
  Future<void> signIn(String email, String password) async {
    UserCredential userCred = await _authService.signIn(email, password);
    await fetchUserData(userCred);
  }

  // SignOut
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUserData = null;
  }

  // SignUp
  Future<void> signUp(String email, String password, String name) async {
    UserCredential? userCred = await _authService.signUp(email, password, name);

    final userModelData = UserModel(
      id: userCred!.user!.uid,
      name: name,
      email: email,
    );

    await _fireStoreService.createUser(userModelData);
    await fetchUserData(userCred);
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchUserData(UserCredential userCred) async {
    _currentUserData =
        await _fireStoreService.fetchUserData(userCred.user!.uid);
  }

  String getUserId() {
    return _currentUserData!.id.toString();
  }
}
