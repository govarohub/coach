/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: email_verification_provider.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailVerificationLoadingProvider = StateProvider<bool>(
  (ref) => false,
);