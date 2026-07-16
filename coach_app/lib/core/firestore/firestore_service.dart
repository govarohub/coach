/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: firestore_service.dart
|--------------------------------------------------------------------------
*/

import 'package:cloud_firestore/cloud_firestore.dart';

final class FirestoreService {
  FirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<void> createUser({
    required String uid,
    required String email,
  }) async {
    await _users.doc(uid).set({
      'uid': uid,
      'email': email,
      'role': 'user',
      'active': true,
      'profileCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, dynamic>?> getUser({
    required String uid,
  }) async {
    final document = await _users.doc(uid).get();

    return document.data();
  }

  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    data['updatedAt'] = FieldValue.serverTimestamp();

    await _users.doc(uid).update(data);
  }

  Future<void> deleteUser({
    required String uid,
  }) async {
    await _users.doc(uid).delete();
  }
}
