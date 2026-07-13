/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_button.dart
| Ubicación: lib/shared/widgets/
|
| Botón reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.isOutlined = false,
    this.width = double.infinity,
    this.height = 52,
  });

  /// Texto del botón.
  final String text;

  /// Acción al presionar.
  final VoidCallback? onPressed;

  /// Icono opcional.
  final IconData? icon;

  /// Estado de carga.
  final bool isLoading;

  /// Habilitado.
  final bool enabled;

  /// Estilo con borde.
  final bool isOutlined;

  /// Ancho.
  final double width;

  /// Alto.
  final double height;

  @override
  Widget build(BuildContext context) {
    final bool canPress =
        enabled && !isLoading && onPressed != null;

    final Widget child = isLoading
        ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    final ButtonStyle style = isOutlined
        ? OutlinedButton.styleFrom(
            minimumSize: Size(width, height),
            side: const BorderSide(
              color: AppColors.primary,
            ),
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )
        : ElevatedButton.styleFrom(
            minimumSize: Size(width, height),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textInverse,
            disabledBackgroundColor: AppColors.grey300,
            disabledForegroundColor: AppColors.grey600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );

    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: canPress ? onPressed : null,
              style: style,
              child: child,
            )
          : ElevatedButton(
              onPressed: canPress ? onPressed : null,
              style: style,
              child: child,
            ),
    );
  }
}