import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/client_service_provider.dart';

Future<bool> showDeleteClientDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String clientId,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Eliminar cliente'),
        content: const Text(
          '¿Deseas eliminar este cliente?',
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
                  .read(clientServiceProvider)
                  .deleteClient(clientId);

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
