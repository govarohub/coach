/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: role_manager.dart
|--------------------------------------------------------------------------
| Administra la obtención y conversión del rol del usuario autenticado.
|--------------------------------------------------------------------------
*/

import '../firestore/firestore_service.dart';
import 'role.dart';

final class RoleManager {
  RoleManager({
    FirestoreService? firestoreService,
  }) : _firestoreService = firestoreService ?? FirestoreService();

  final FirestoreService _firestoreService;

  /// Obtiene el rol del usuario desde Firestore.
  ///
  /// Si el documento no existe o el campo role es inválido,
  /// se devuelve UserRole.user como valor por defecto.
  Future<UserRole> getUserRole({
    required String uid,
  }) async {
    final userData = await _firestoreService.getUser(uid: uid);

    if (userData == null) {
      return UserRole.user;
    }

    final String role =
        (userData['role'] as String?)?.trim().toLowerCase() ?? 'user';

    switch (role) {
      case 'admin':
        return UserRole.admin;

      case 'coach':
        return UserRole.coach;

      case 'user':
      default:
        return UserRole.user;
    }
  }
}
