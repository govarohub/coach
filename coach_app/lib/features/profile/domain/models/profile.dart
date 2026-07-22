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

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      uid: map['uid'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      isCoach: map['isCoach'] as bool,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
    );
  }
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

  /// Indica si el nombre es válido.
  bool get hasValidFirstName {
    final value = firstName.trim();

    return value.length >= 2;
  }

  /// Indica si el apellido es válido.
  bool get hasValidLastName {
    final value = lastName.trim();

    return value.length >= 2;
  }

  /// Indica si el teléfono es válido.
  bool get hasValidPhone {
    final value = phone.trim();

    return value.length >= 10;
  }

  /// Indica si el perfil es válido.
  bool get isValid {
    return hasValidFirstName &&
        hasValidLastName &&
        hasValidPhone;
  }

  /// Convierte el perfil a un mapa.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'isCoach': isCoach,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

