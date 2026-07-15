/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: auth_exception_mapper.dart
|--------------------------------------------------------------------------
*/

import 'package:firebase_auth/firebase_auth.dart';

final class AuthExceptionMapper {
  const AuthExceptionMapper._();

  static String message(
    FirebaseAuthException exception,
  ) {
    switch (exception.code) {
      case 'invalid-email':
        return 'El correo electrónico no es válido.';

      case 'user-not-found':
        return 'No existe una cuenta con ese correo.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';

      case 'email-already-in-use':
        return 'El correo ya está registrado.';

      case 'weak-password':
        return 'La contraseña es demasiado débil.';

      case 'too-many-requests':
        return 'Demasiados intentos. Intente más tarde.';

      case 'network-request-failed':
        return 'Sin conexión a Internet.';

      default:
        return 'Ocurrió un error inesperado.';
    }
  }
}