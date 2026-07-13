/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: splash_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../../../shared/widgets/base_scaffold.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Center(
        child: Text(
          'Coach',
        ),
      ),
    );
  }
}