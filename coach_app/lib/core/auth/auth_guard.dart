/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: auth_guard.dart
|--------------------------------------------------------------------------
| Adaptador del estado de autenticación basado en Firebase.
|--------------------------------------------------------------------------
*/

import 'auth_service.dart';

final class AuthGuard {
  AuthGuard._();

  static bool get isAuthenticated {
    return AuthService().isAuthenticated;
  }
}