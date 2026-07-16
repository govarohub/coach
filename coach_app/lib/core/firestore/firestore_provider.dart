/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: firestore_provider.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>(
      (ref) {
    return FirestoreService();
  },
);
