/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: app_colors.dart
| Ubicación: lib/core/theme/
|
| Descripción:
| Centraliza todos los colores oficiales de la aplicación Coach.
| Ningún Widget deberá utilizar colores directamente.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

/// Paleta oficial de colores del proyecto Coach.
final class AppColors {
  AppColors._();

  //======================================================================
  // Marca
  //======================================================================

  /// Azul principal de Coach.
  static const Color primary = Color(0xFF1565C0);

  /// Azul utilizado para estados presionados.
  static const Color primaryDark = Color(0xFF0D47A1);

  /// Azul claro para elementos secundarios.
  static const Color primaryLight = Color(0xFF42A5F5);

  //======================================================================
  // Secundarios
  //======================================================================

  static const Color secondary = Color(0xFFFFFFFF);

  static const Color secondaryDark = Color(0xFFF5F7FA);

  //======================================================================
  // Estados
  //======================================================================

  static const Color success = Color(0xFF2E7D32);

  static const Color warning = Color(0xFFFB8C00);

  static const Color error = Color(0xFFD32F2F);

  static const Color info = Color(0xFF0288D1);

  //======================================================================
  // Fondos
  //======================================================================

  static const Color background = Color(0xFFF8FAFC);

  static const Color surface = Color(0xFFFFFFFF);

  static const Color card = Color(0xFFFFFFFF);

  //======================================================================
  // Texto
  //======================================================================

  static const Color textPrimary = Color(0xFF212121);

  static const Color textSecondary = Color(0xFF616161);

  static const Color textHint = Color(0xFF9E9E9E);

  static const Color textDisabled = Color(0xFFBDBDBD);

  static const Color textInverse = Color(0xFFFFFFFF);

  //======================================================================
  // Bordes
  //======================================================================

  static const Color border = Color(0xFFE0E0E0);

  static const Color divider = Color(0xFFEEEEEE);

  //======================================================================
  // Estados de Coach
  //======================================================================

  static const Color coachAvailable = Color(0xFF43A047);

  static const Color coachBusy = Color(0xFFF4511E);

  static const Color coachOffline = Color(0xFF9E9E9E);

  //======================================================================
  // Reservaciones
  //======================================================================

  static const Color reservationPending = Color(0xFFFFA000);

  static const Color reservationAccepted = Color(0xFF1976D2);

  static const Color reservationStarted = Color(0xFF00897B);

  static const Color reservationCompleted = Color(0xFF2E7D32);

  static const Color reservationCancelled = Color(0xFFD32F2F);

  //======================================================================
  // Pagos
  //======================================================================

  static const Color paymentApproved = Color(0xFF2E7D32);

  static const Color paymentPending = Color(0xFFF9A825);

  static const Color paymentRejected = Color(0xFFC62828);

  static const Color paymentRefund = Color(0xFF6A1B9A);

  //======================================================================
  // Mapa
  //======================================================================

  static const Color mapRoute = Color(0xFF1565C0);

  static const Color mapDestination = Color(0xFFD32F2F);

  static const Color mapOrigin = Color(0xFF43A047);

  //======================================================================
  // Redes sociales (uso futuro)
  //======================================================================

  static const Color google = Color(0xFFDB4437);

  static const Color facebook = Color(0xFF1877F2);

  static const Color apple = Color(0xFF000000);

  //======================================================================
  // Escala de grises
  //======================================================================

  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
}