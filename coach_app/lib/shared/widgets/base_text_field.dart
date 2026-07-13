/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: base_text_field.dart
| Ubicación: lib/shared/widgets/
|
| Campo de captura reutilizable para toda la aplicación.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    required this.controller,
    required this.label,
    super.key,
    this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onChanged,
  });

  /// Controlador del campo.
  final TextEditingController controller;

  /// Etiqueta.
  final String label;

  /// Texto de ayuda.
  final String? hint;

  /// Validador.
  final String? Function(String?)? validator;

  /// Tipo de teclado.
  final TextInputType keyboardType;

  /// Acción del teclado.
  final TextInputAction textInputAction;

  /// Icono izquierdo.
  final IconData? prefixIcon;

  /// Icono derecho.
  final Widget? suffixIcon;

  /// Campo oculto (contraseña).
  final bool obscureText;

  /// Campo habilitado.
  final bool enabled;

  /// Solo lectura.
  final bool readOnly;

  /// Número máximo de líneas.
  final int maxLines;

  /// Longitud máxima.
  final int? maxLength;

  /// Evento al presionar.
  final VoidCallback? onTap;

  /// Evento al cambiar el texto.
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
      ),
    );
  }
}