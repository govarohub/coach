/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: forgot_password_provider.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordLoadingProvider = StateProvider<bool>(
  (ref) => false,
);