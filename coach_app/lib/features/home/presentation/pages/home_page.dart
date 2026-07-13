    /*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: home_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      appBar: BaseAppBar(
        title: 'Coach',
        showBackButton: false,
      ),
      body: Center(
        child: Text(
          'Pantalla principal',
        ),
      ),
    );
  }
}