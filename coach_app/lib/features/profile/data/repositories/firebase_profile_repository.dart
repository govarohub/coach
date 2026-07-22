/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: firebase_profile_repository.dart
|--------------------------------------------------------------------------
| Implementación del repositorio de perfiles utilizando Cloud Firestore.
|--------------------------------------------------------------------------
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/profile.dart';
import 'profile_repository.dart';

final class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<Profile?> getProfile(String uid) async {
    final document =
    await _firestore.collection('users').doc(uid).get();

    if (!document.exists) {
      return null;
    }

    final data = document.data();

    if (data == null) {
      return null;
    }

    return Profile.fromMap(data);
  }

  @override
  Future<void> createProfile(Profile profile) async {
    await _firestore.collection('users').doc(profile.uid).set({
      ...profile.toMap(),
      'profileCompleted': profile.isValid,
    });
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await _firestore.collection('users').doc(profile.uid).update({
      ...profile.toMap(),
      'profileCompleted': profile.isValid,
    });
  }
}
