/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: register_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Registro',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: BaseButton(
            text: 'Volver al inicio',
            onPressed: () {
              context.go(AppRoutes.login);
            },
          ),
        ),
      ),
    );
  }
}