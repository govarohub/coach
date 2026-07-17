/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: session_provider.dart
|--------------------------------------------------------------------------
| Providers relacionados con la sesión del usuario.
|--------------------------------------------------------------------------
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_manager.dart';
import 'session_state.dart';

final sessionManagerProvider = Provider<SessionManager>(
      (ref) {
    return SessionManager();
  },
);

final sessionStateProvider = StreamProvider<SessionState>(
      (ref) {
    return ref.read(sessionManagerProvider).sessionStateChanges();
  },
);
