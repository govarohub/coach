/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: calendar_page.dart
|--------------------------------------------------------------------------
| Pantalla principal del calendario.
| El contenido funcional se implementará en los siguientes CK.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Calendario',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
