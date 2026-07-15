/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: app_bootstrap.dart
|--------------------------------------------------------------------------
| Inicialización global de la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

final class AppBootstrap {
  const AppBootstrap._();

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}