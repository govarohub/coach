/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: home_content_page.dart
| Ubicación: lib/features/home/presentation/pages/
|--------------------------------------------------------------------------
| Contenido de la pestaña Inicio.
| Esta pantalla será utilizada dentro del IndexedStack de HomePage.
| Aquí se mostrarán posteriormente las funciones principales del coach.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center_rounded,
              size: 72,
            ),
            SizedBox(height: 24),
            Text(
              'Bienvenido a Coach',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Esta será la pantalla principal de la aplicación.\n\n'
                  'Aquí aparecerán tus entrenamientos, reservas, progreso, '
                  'estadísticas y accesos rápidos.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
