/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: auth_guard.dart
|--------------------------------------------------------------------------
| Guard de autenticación temporal.
|--------------------------------------------------------------------------
*/

class AuthGuard {
  AuthGuard._();

  /// Estado temporal.
  ///
  /// En CK-006 será reemplazado por Firebase Authentication.
  static bool isAuthenticated = false;
}