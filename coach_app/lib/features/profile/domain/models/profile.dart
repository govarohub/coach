/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: profile.dart
|--------------------------------------------------------------------------
| Modelo de dominio del perfil del usuario.
|--------------------------------------------------------------------------
*/

final class Profile {
  const Profile({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.isCoach,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Identificador único del usuario en Firebase Authentication.
  final String uid;

  /// Correo electrónico del usuario.
  final String email;

  /// Nombre(s) del usuario.
  final String firstName;

  /// Apellidos del usuario.
  final String lastName;

  /// Número telefónico del usuario.
  final String phone;

  /// Indica si el perfil pertenece a un Coach.
  final bool isCoach;

  /// Fecha de creación del perfil.
  final DateTime createdAt;

  /// Fecha de la última actualización del perfil.
  final DateTime updatedAt;
}
