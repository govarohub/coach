/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: session_state.dart
|--------------------------------------------------------------------------
| Define los estados globales de la sesión del usuario.
|--------------------------------------------------------------------------
*/

enum SessionState {
  /// Inicializando la aplicación.
  loading,

  /// No existe un usuario autenticado.
  unauthenticated,

  /// Usuario autenticado, pero sin verificar el correo.
  emailNotVerified,

  /// Usuario autenticado con correo verificado,
  /// pero con perfil incompleto.
  profileIncomplete,

  /// Usuario autenticado, correo verificado
  /// y perfil completo.
  authenticated,

  /// Usuario deshabilitado.
  disabled,
}
