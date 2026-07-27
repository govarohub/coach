import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/training_service_provider.dart';

Future<bool> showDeleteTrainingDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String trainingId,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Eliminar entrenamiento'),
        content: const Text(
          '¿Deseas eliminar este entrenamiento?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false);
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              await ref
                  .read(trainingServiceProvider)
                  .deleteTraining(trainingId);

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(true);
              }
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
