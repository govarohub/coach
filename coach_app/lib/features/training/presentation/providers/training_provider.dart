import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_provider.dart';
import '../../data/providers/training_service_provider.dart';
import '../../domain/models/training.dart';

final trainingProvider =
FutureProvider.autoDispose<List<Training>>((ref) async {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    return <Training>[];
  }

  final trainingService = ref.watch(trainingServiceProvider);

  return trainingService.getUserTrainings(
    authState.uid,
  );
});
