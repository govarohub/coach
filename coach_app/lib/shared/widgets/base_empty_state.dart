/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_empty_state.dart
| Ubicación: lib/shared/widgets/
|
| Estado vacío reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BaseEmptyState extends StatelessWidget {
  const BaseEmptyState({
    required this.title,
    required this.message,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.buttonText,
    this.onPressed,
  });

  /// Título principal.
  final String title;

  /// Mensaje descriptivo.
  final String message;

  /// Icono mostrado.
  final IconData icon;

  /// Texto del botón opcional.
  final String? buttonText;

  /// Acción del botón.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 72,
              color: AppColors.primary,
            ),

            const SizedBox(height: 24),

            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            if (buttonText != null && onPressed != null) ...[
              const SizedBox(height: 24),

              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(buttonText!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}