/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: profile_form.dart
|--------------------------------------------------------------------------
| ET-013.3.2
| Widget reutilizable para captura y edición del perfil.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';

import '../../domain/models/profile.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    required this.profile,
    required this.onSave,
    super.key,
    this.isLoading = false,
    this.buttonText = 'Guardar',
  });

  final Profile profile;
  final ValueChanged<Profile> onSave;
  final String buttonText;
  final bool isLoading;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        TextEditingController(text: widget.profile.firstName);

    _lastNameController =
        TextEditingController(text: widget.profile.lastName);

    _phoneController =
        TextEditingController(text: widget.profile.phone);

    _emailController =
        TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.isLoading) {
      return;
    }

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    widget.onSave(
      widget.profile.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !widget.isLoading,
            controller: _firstNameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.isEmpty) return 'Ingrese su nombre.';
              if (text.length < 2) return 'Mínimo 2 caracteres.';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            enabled: !widget.isLoading,
            controller: _lastNameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Apellidos',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.isEmpty) return 'Ingrese sus apellidos.';
              if (text.length < 2) return 'Mínimo 2 caracteres.';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            enabled: !widget.isLoading,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Teléfono',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final text = value?.replaceAll(RegExp(r'\s+'), '') ?? '';
              if (text.isEmpty) return 'Ingrese su teléfono.';
              if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
                return 'Solo números.';
              }
              if (text.length < 10) return 'Mínimo 10 dígitos.';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            enabled: false,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: widget.isLoading
                ? null
                : _submit,
            child: widget.isLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
                : Text(widget.buttonText),
          ),
        ],
      ),
    );
  }
}
