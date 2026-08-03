import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../../../../shared/widgets/base_text_field.dart';

import '../../data/providers/client_service_provider.dart';
import '../../domain/models/client.dart';

class ClientFormPage extends ConsumerStatefulWidget {
  const ClientFormPage({
    super.key,
  });

  @override
  ConsumerState<ClientFormPage> createState() =>
      _ClientFormPageState();
}

class _ClientFormPageState
    extends ConsumerState<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController =
  TextEditingController();

  final _lastNameController =
  TextEditingController();

  final _emailController =
  TextEditingController();

  final _phoneController =
  TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveClient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();

    final client = Client(
      id: now.microsecondsSinceEpoch.toString(),
      coachId: '',
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      birthDate: now,
      gender: '',
      status: 'active',
      createdAt: now,
      updatedAt: now,
    );

    await ref
        .read(clientServiceProvider)
        .createClient(client);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Nuevo cliente',
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BaseTextField(
                  controller: _firstNameController,
                  label: 'Nombre',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingrese el nombre';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                BaseTextField(
                  controller: _lastNameController,
                  label: 'Apellido',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingrese el apellido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                BaseTextField(
                  controller: _emailController,
                  label: 'Correo electrónico',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingrese el correo electrónico';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                BaseTextField(
                  controller: _phoneController,
                  label: 'Teléfono',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingrese el teléfono';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                BaseButton(
                  text: 'Guardar cliente',
                  onPressed: _saveClient,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
