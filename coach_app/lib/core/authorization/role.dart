/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: role.dart
|--------------------------------------------------------------------------
| Define los roles disponibles dentro de la aplicación.
|--------------------------------------------------------------------------
*/

/// Roles soportados por la aplicación.
///
/// Este enum representa únicamente la autorización.
/// No tiene relación con el estado de autenticación
/// administrado por SessionManager.
enum UserRole {
  /// Cliente de la aplicación.
  user,

  /// Entrenador.
  coach,

  /// Administrador.
  admin,
}
