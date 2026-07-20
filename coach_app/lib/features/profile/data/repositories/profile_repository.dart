/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: profile_repository.dart
|--------------------------------------------------------------------------
| Contrato base para la administración de perfiles.
|--------------------------------------------------------------------------
*/

import '../../domain/models/profile.dart';

abstract interface class ProfileRepository {
  /// Obtiene el perfil asociado al identificador del usuario.
  Future<Profile?> getProfile(String uid);

  /// Crea un nuevo perfil.
  Future<void> createProfile(Profile profile);

  /// Actualiza un perfil existente.
  Future<void> updateProfile(Profile profile);
}
