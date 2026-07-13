/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: login_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../../../../core/auth/auth_guard.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Iniciar sesión',
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseButton(
              text: 'Entrar',
              onPressed: () {
                context.go(AppRoutes.home);
              },
            ),
            const SizedBox(height: 16),
            BaseButton(
              text: 'Crear cuenta',
              isOutlined: true,
              onPressed: () {
                AuthGuard.isAuthenticated = true;
                context.go(AppRoutes.home);
                },
            ),
          ],
        ),
      ),
    );
  }
}