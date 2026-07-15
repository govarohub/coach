/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: auth_service.dart
|--------------------------------------------------------------------------
*/

import 'package:firebase_auth/firebase_auth.dart';

final class AuthService {
  AuthService({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}