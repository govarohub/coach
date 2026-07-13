/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_loader.dart
| Ubicación: lib/shared/widgets/
|
| Indicador de carga reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BaseLoader extends StatelessWidget {
  const BaseLoader({
    super.key,
    this.message,
    this.size = 42,
    this.strokeWidth = 3,
    this.color,
  });

  /// Mensaje mostrado debajo del indicador.
  final String? message;

  /// Tamaño del indicador.
  final double size;

  /// Grosor del indicador.
  final double strokeWidth;

  /// Color del indicador.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}