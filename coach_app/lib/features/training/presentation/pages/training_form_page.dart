import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../../../../shared/widgets/base_text_field.dart';

import '../../data/providers/training_service_provider.dart';
import '../../domain/models/training.dart';

class TrainingFormPage extends ConsumerStatefulWidget {
  const TrainingFormPage({
    super.key,
  });

  @override
  ConsumerState<TrainingFormPage> createState() =>
      _TrainingFormPageState();
}

class _TrainingFormPageState
    extends ConsumerState<TrainingFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _descriptionController =
  TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTraining() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();

    final training = Training(
      id: now.microsecondsSinceEpoch.toString(),

      coachId: '',

      userId: '',

      title: _titleController.text.trim(),

      description:
      _descriptionController.text.trim(),

      startDate: now,

      endDate: now,

      status: 'draft',

      createdAt: now,

      updatedAt: now,
    );

    await ref
        .read(trainingServiceProvider)
        .createTraining(training);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Nuevo entrenamiento',
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
                  controller:
                  _descriptionController,
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
                  text: 'Guardar entrenamiento',
                  onPressed: _saveTraining,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
