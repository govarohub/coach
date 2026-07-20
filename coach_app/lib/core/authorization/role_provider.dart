/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: role_provider.dart
|--------------------------------------------------------------------------
| Providers relacionados con la autorización del usuario.
|--------------------------------------------------------------------------
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'role_manager.dart';

final roleManagerProvider = Provider<RoleManager>(
      (ref) {
    return RoleManager();
  },
);
