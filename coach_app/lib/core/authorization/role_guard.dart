/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: role_guard.dart
|--------------------------------------------------------------------------
| Utilidad para validar si un rol tiene acceso a un recurso.
|--------------------------------------------------------------------------
*/

import 'role.dart';

final class RoleGuard {
  const RoleGuard._();

  /// Indica si el [userRole] pertenece a los [allowedRoles].
  static bool canAccess({
    required UserRole userRole,
    required List<UserRole> allowedRoles,
  }) {
    return allowedRoles.contains(userRole);
  }
}
