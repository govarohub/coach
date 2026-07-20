/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: disabled_account_page.dart
|--------------------------------------------------------------------------
| Pantalla mostrada cuando la cuenta del usuario ha sido deshabilitada.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

final class DisabledAccountPage extends StatelessWidget {
  const DisabledAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cuenta deshabilitada'),
      ),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  size: 72,
                ),
                SizedBox(height: 24),
                Text(
                  'Tu cuenta ha sido deshabilitada.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Si consideras que esto es un error, '
                      'ponte en contacto con el administrador.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
