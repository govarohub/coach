import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_provider.dart';

import '../../data/providers/client_service_provider.dart';
import '../../domain/models/client.dart';

final clientProvider =
FutureProvider.autoDispose<List<Client>>((ref) async {
  final authState = await ref.watch(authStateProvider.future);

  if (authState == null) {
    return <Client>[];
  }

  final clientService = ref.watch(
    clientServiceProvider,
  );

  return clientService.getCoachClients(
    authState.uid,
  );
});
