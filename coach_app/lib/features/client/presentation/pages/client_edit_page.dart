import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../../../../shared/widgets/base_text_field.dart';

import '../../data/providers/client_service_provider.dart';
import '../../domain/models/client.dart';

class ClientEditPage extends ConsumerStatefulWidget {
  const ClientEditPage({
    required this.client,
    super.key,
  });

  final Client client;

  @override
  ConsumerState<ClientEditPage> createState() =>
      _ClientEditPageState();
}

class _ClientEditPageState
    extends ConsumerState<ClientEditPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(
      text: widget.client.firstName,
    );

    _lastNameController = TextEditingController(
      text: widget.client.lastName,
    );

    _emailController = TextEditingController(
      text: widget.client.email,
    );

    _phoneController = TextEditingController(
      text: widget.client.phone,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _updateClient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedClient = Client(
      id: widget.client.id,
      coachId: widget.client.coachId,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      birthDate: widget.client.birthDate,
      gender: widget.client.gender,
      status: widget.client.status,
      createdAt: widget.client.createdAt,
      updatedAt: DateTime.now(),
    );

    await ref
        .read(clientServiceProvider)
        .updateClient(updatedClient);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(updatedClient);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Editar cliente',
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
                  text: 'Guardar cambios',
                  onPressed: _updateClient,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
