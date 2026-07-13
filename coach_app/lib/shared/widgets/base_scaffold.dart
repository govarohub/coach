/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_scaffold.dart
| Ubicación: lib/shared/widgets/
|
| Scaffold base reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BaseScaffold extends StatelessWidget {
const BaseScaffold({
  required this.body,
  super.key,
  this.appBar,
  this.backgroundColor,
  this.floatingActionButton,
  this.bottomNavigationBar,
  this.drawer,
  this.endDrawer,
  this.bottomSheet,
  this.resizeToAvoidBottomInset = true,
  this.safeArea = true,
  this.padding = EdgeInsets.zero,
});
  /// Contenido principal de la pantalla.
  final Widget body;

  /// Barra superior.
  final PreferredSizeWidget? appBar;

  /// Color de fondo.
  final Color? backgroundColor;

  /// Botón flotante.
  final Widget? floatingActionButton;

  /// Barra inferior.
  final Widget? bottomNavigationBar;

  /// Menú lateral izquierdo.
  final Widget? drawer;

  /// Menú lateral derecho.
  final Widget? endDrawer;

  /// BottomSheet.
  final Widget? bottomSheet;

  /// Ajustar contenido cuando aparece el teclado.
  final bool resizeToAvoidBottomInset;

  /// Utilizar SafeArea.
  final bool safeArea;

  /// Padding interno.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: body,
    );

    if (safeArea) {
      content = SafeArea(
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}