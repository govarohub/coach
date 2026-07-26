/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: home_profile_provider.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_provider.dart';
import '../../../../core/firestore/firestore_provider.dart';

final homeProfileProvider =
FutureProvider<Map<String, dynamic>?>((ref) async {
  final user = await ref.watch(authStateProvider.future);

  if (user == null) {
    return null;
  }

  return ref
      .read(firestoreServiceProvider)
      .getUser(uid: user.uid);
});
