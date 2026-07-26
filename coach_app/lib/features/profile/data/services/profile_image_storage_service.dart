import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

/// Servicio responsable de almacenar imágenes de perfil
/// en Firebase Storage.
final class ProfileImageStorageService {
  ProfileImageStorageService({
    FirebaseStorage? storage,
  }) : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  /// Sube la imagen del usuario y devuelve la URL pública.
  Future<String> uploadProfileImage({
    required String uid,
    required XFile image,
  }) async {
    final reference = _storage.ref().child(
      'users/$uid/profile.jpg',
    );

    await reference.putFile(
      File(image.path),
    );

    return reference.getDownloadURL();
  }
}
