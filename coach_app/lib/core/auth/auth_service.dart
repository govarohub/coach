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

  Future<UserCredential> signIn({
    required String email,
    required String password,
    }) async {
      return _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
    );
  }

  
  Future<UserCredential> register({
    required String email,
    required String password,
    }) async {
      return _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
        );
      }

Future<void> sendPasswordReset({
  required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(
      email: email.trim(),
      );
    }

Future<void> sendEmailVerification() async {
  final user = _firebaseAuth.currentUser;
  
  if (user == null) {
    return;
  }

  if (!user.emailVerified) {
    await user.sendEmailVerification();
  }
}

Future<void> reloadUser() async {
  await _firebaseAuth.currentUser?.reload();
}

bool get isEmailVerified {
  return _firebaseAuth.currentUser?.emailVerified ?? false;
}

  bool get isAuthenticated {
    return _firebaseAuth.currentUser != null;
    }
}