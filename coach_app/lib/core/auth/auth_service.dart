/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: auth_service.dart
|--------------------------------------------------------------------------
*/

import 'package:firebase_auth/firebase_auth.dart';

import '../firestore/firestore_service.dart';

final class AuthService {
  AuthService({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  final FirestoreService _firestoreService = FirestoreService();

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
    final credential =
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user != null) {
      await _firestoreService.createUser(
        uid: user.uid,
        email: user.email ?? email.trim(),
      );
    }

    return credential;
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
