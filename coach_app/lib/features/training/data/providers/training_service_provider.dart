import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/training_service.dart';

final trainingServiceProvider = Provider<TrainingService>(
      (ref) => TrainingService(),
);
