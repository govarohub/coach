/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: splash_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/base_loader.dart';
import '../../../../shared/widgets/base_scaffold.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          context.go(AppRoutes.login);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: BaseLoader(
        message: 'Iniciando Coach...',
      ),
    );
  }
}