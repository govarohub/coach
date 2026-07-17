/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: auth_guard.dart
|--------------------------------------------------------------------------
| Utilidades para validar el estado de la sesión.
|--------------------------------------------------------------------------
*/

import 'session_manager.dart';
import 'session_state.dart';

final class AuthGuard {
  AuthGuard._();

  static final SessionManager _sessionManager = SessionManager();

  /// Devuelve el estado completo de la sesión.
  static Future<SessionState> sessionState() {
    return _sessionManager.currentSessionState();
  }
}
