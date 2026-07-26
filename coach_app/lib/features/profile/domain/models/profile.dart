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
    this.photoUrl,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      uid: map['uid'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      isCoach: map['isCoach'] as bool,
      photoUrl: map['photoUrl'] as String?,
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

  /// URL de la fotografía de perfil.
  final String? photoUrl;

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

  /// Crea una copia del perfil modificando únicamente los campos indicados.
  Profile copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    bool? isCoach,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? photoUrl,
  }) {
    return Profile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      isCoach: isCoach ?? this.isCoach,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      photoUrl: photoUrl ?? this.photoUrl,
    );
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
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

