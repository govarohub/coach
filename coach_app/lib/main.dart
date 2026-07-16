/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: main.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/bootstrap/app_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.initialize();

  runApp(
    const ProviderScope(
      child: CoachApp(),
      ),
  );

}