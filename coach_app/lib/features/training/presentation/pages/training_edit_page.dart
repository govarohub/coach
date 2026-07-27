import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../../../../shared/widgets/base_text_field.dart';

import '../../data/providers/training_service_provider.dart';
import '../../domain/models/training.dart';

class TrainingEditPage extends ConsumerStatefulWidget {
  const TrainingEditPage({
    required this.training,
    super.key,
  });

  final Training training;

  @override
  ConsumerState<TrainingEditPage> createState() =>
      _TrainingEditPageState();
}

class _TrainingEditPageState
    extends ConsumerState<TrainingEditPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.training.title,
    );

    _descriptionController = TextEditingController(
      text: widget.training.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateTraining() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedTraining = Training(
      id: widget.training.id,
      coachId: widget.training.coachId,
      userId: widget.training.userId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      startDate: widget.training.startDate,
      endDate: widget.training.endDate,
      status: widget.training.status,
      createdAt: widget.training.createdAt,
      updatedAt: DateTime.now(),
    );

    await ref
        .read(trainingServiceProvider)
        .updateTraining(updatedTraining);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(updatedTraining);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Editar entrenamiento',
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BaseTextField(
                  controller: _titleController,
                  label: 'Título',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingrese un título';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                BaseTextField(
                  controller: _descriptionController,
                  label: 'Descripción',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingrese una descripción';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                BaseButton(
                  text: 'Guardar cambios',
                  onPressed: _updateTraining,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
