import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_scaffold.dart';

import '../../domain/models/training.dart';
import '../providers/training_provider.dart';

class TrainingListPage extends ConsumerWidget {
  const TrainingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainings = ref.watch(trainingProvider);

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Entrenamientos',
      ),
      body: trainings.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stackTrace) => const Center(
          child: Text(
            'No fue posible cargar los entrenamientos.',
          ),
        ),

        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'No hay entrenamientos registrados.',
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (context, index) =>
            const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final training = items[index];

              return _TrainingCard(
                training: training,
              );
            },
          );
        },
      ),
    );
  }
}

class _TrainingCard extends StatelessWidget {
  const _TrainingCard({
    required this.training,
  });

  final Training training;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  .titleMedium,
            ),

            const SizedBox(height: 8),

            Text(training.description),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                ),

                const SizedBox(width: 8),

                Text(
                  '${training.startDate.day}/${training.startDate.month}/${training.startDate.year}',
                ),
              ],
            ),

            const SizedBox(height: 8),

            Chip(
              label: Text(training.status),
            ),
          ],
        ),
      ),
    );
  }
}
