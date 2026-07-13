/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_card.dart
| Ubicación: lib/shared/widgets/
|
| Tarjeta reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.backgroundColor,
    this.borderRadius = 12,
    this.onTap,
  });

  /// Contenido de la tarjeta.
  final Widget child;

  /// Espaciado interno.
  final EdgeInsetsGeometry padding;

  /// Margen externo.
  final EdgeInsetsGeometry margin;

  /// Color de fondo.
  final Color? backgroundColor;

  /// Radio de las esquinas.
  final double borderRadius;

  /// Acción al presionar la tarjeta.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.card,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: AppShadows.card,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: content,
        ),
      );
    }

    return content;
  }
}