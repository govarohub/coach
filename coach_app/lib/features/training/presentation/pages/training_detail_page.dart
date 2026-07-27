import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_scaffold.dart';

import '../../data/providers/training_service_provider.dart';
import '../../domain/models/training.dart';

final trainingDetailProvider =
FutureProvider.family<Training?, String>((ref, trainingId) async {
  final service = ref.watch(trainingServiceProvider);

  return service.getTraining(trainingId);
});

class TrainingDetailPage extends ConsumerWidget {
  const TrainingDetailPage({
    required this.trainingId,
    super.key,
  });

  final String trainingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final training = ref.watch(
      trainingDetailProvider(trainingId),
    );

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Detalle del entrenamiento',
      ),
      body: training.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stackTrace) => const Center(
          child: Text(
            'No fue posible cargar el entrenamiento.',
          ),
        ),

        data: (training) {
          if (training == null) {
            return const Center(
              child: Text(
                'Entrenamiento no encontrado.',
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      training.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),

                    const SizedBox(height: 16),

                    Text(training.description),

                    const SizedBox(height: 24),

                    _InfoRow(
                      label: 'Inicio',
                      value:
                      '${training.startDate.day}/${training.startDate.month}/${training.startDate.year}',
                    ),

                    const SizedBox(height: 12),

                    _InfoRow(
                      label: 'Fin',
                      value:
                      '${training.endDate.day}/${training.endDate.month}/${training.endDate.year}',
                    ),

                    const SizedBox(height: 12),

                    _InfoRow(
                      label: 'Estado',
                      value: training.status,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
