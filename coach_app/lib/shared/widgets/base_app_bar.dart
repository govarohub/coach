/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_app_bar.dart
| Ubicación: lib/shared/widgets/
|
| Barra superior reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

import 'package:go_router/go_router.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    required this.title,
    super.key,
    this.centerTitle = true,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
    this.actions,
    this.elevation = 0,
    this.leading,
  });

  /// Título de la barra.
  final String title;

  /// Centrar el título.
  final bool centerTitle;

  /// Mostrar botón de regreso.
  final bool showBackButton;

  /// Color de fondo.
  final Color? backgroundColor;

  /// Color del texto e íconos.
  final Color? foregroundColor;

  /// Acciones del AppBar.
  final List<Widget>? actions;

  /// Elevación.
  final double elevation;

  /// Widget personalizado en la parte izquierda.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: foregroundColor ?? AppColors.textInverse,
      title: Text(title),
      actions: actions,
      automaticallyImplyLeading: false,
      leading: leading ??
          (showBackButton && Navigator.of(context).canPop()
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => context.pop(),
                )
              : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}