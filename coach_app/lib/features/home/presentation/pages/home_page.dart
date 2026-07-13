/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: home_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/auth/auth_guard.dart';
import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Coach',
        showBackButton: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pantalla principal',
            ),
            const SizedBox(height: 24),
            BaseButton(
              text: 'Cerrar sesión',
              isOutlined: true,
              onPressed: () {
                AuthGuard.isAuthenticated = false;
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}