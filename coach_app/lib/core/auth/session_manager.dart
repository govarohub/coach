/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: session_manager.dart
|--------------------------------------------------------------------------
| Administra el estado global de la sesión del usuario.
|--------------------------------------------------------------------------
*/

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../firestore/firestore_service.dart';
import 'auth_service.dart';
import 'session_state.dart';

final class SessionManager {
  SessionManager({
    AuthService? authService,
    FirestoreService? firestoreService,
  })  : _authService = authService ?? AuthService(),
        _firestoreService = firestoreService ?? FirestoreService();

  final AuthService _authService;
  final FirestoreService _firestoreService;

  /// Stream reactivo del estado de sesión.
  Stream<SessionState> sessionStateChanges() {
    return _authService.authStateChanges().asyncMap(
      _resolveSessionState,
    );
  }

  /// Obtiene el estado actual de la sesión.
  Future<SessionState> currentSessionState() async {
    return _resolveSessionState(_authService.currentUser);
  }

  /// Resuelve el estado completo del usuario.
  Future<SessionState> _resolveSessionState(
      User? user,
      ) async {
    if (user == null) {
      return SessionState.unauthenticated;
    }

    await _authService.reloadUser();

    if (!_authService.isEmailVerified) {
      return SessionState.emailNotVerified;
    }

    final userData = await _firestoreService.getUser(
      uid: user.uid,
    );

    if (userData == null) {
      return SessionState.unauthenticated;
    }

    final bool active =
        (userData['active'] as bool?) ?? false;

    if (!active) {
      return SessionState.disabled;
    }

    final bool profileCompleted =
        (userData['profileCompleted'] as bool?) ?? false;

    if (!profileCompleted) {
      return SessionState.profileIncomplete;
    }

    return SessionState.authenticated;
  }
}
