import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_scaffold.dart';

import '../../data/providers/client_service_provider.dart';
import '../../domain/models/client.dart';

import '../widgets/delete_client_dialog.dart';
import 'client_edit_page.dart';

final clientDetailProvider =
FutureProvider.family<Client?, String>(
      (ref, clientId) async {
    final service = ref.watch(
      clientServiceProvider,
    );

    return service.getClient(clientId);
  },
);

class ClientDetailPage extends ConsumerStatefulWidget {
  const ClientDetailPage({
    required this.clientId,
    super.key,
  });

  final String clientId;

  @override
  ConsumerState<ClientDetailPage> createState() =>
      _ClientDetailPageState();
}

class _ClientDetailPageState
    extends ConsumerState<ClientDetailPage> {
  Future<void> _editClient(
      Client client,
      ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ClientEditPage(
          client: client,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    ref.invalidate(
      clientDetailProvider(widget.clientId),
    );
  }

  Future<void> _deleteClient(
      Client client,
      ) async {
    final deleted =
    await showDeleteClientDialog(
      context: context,
      ref: ref,
      clientId: client.id,
    );

    if (!mounted || !deleted) {
      return;
    }

    //ref.invalidate(clientProvider);

    Navigator.of(context).pop();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final client = ref.watch(
      clientDetailProvider(
        widget.clientId,
      ),
    );

    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'Detalle del cliente',
        actions: [
          if (client.hasValue &&
              client.value != null) ...[
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
              ),
              tooltip: 'Editar',
              onPressed: () {
                _editClient(
                  client.value!,
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              tooltip: 'Eliminar',
              onPressed: () {
                _deleteClient(
                  client.value!,
                );
              },
            ),
          ],
        ],
      ),
      body: client.when(
        loading: () => const Center(
          child:
          CircularProgressIndicator(),
        ),
        error: (
            error,
            stackTrace,
            ) =>
        const Center(
          child: Text(
            'No fue posible cargar el cliente.',
          ),
        ),
        data: (client) {
          if (client == null) {
            return const Center(
              child: Text(
                'Cliente no encontrado.',
              ),
            );
          }

          return SingleChildScrollView(
            padding:
            const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding:
                const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      '${client.firstName} ${client.lastName}',
                      style: Theme.of(
                        context,
                      )
                          .textTheme
                          .headlineSmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _InfoRow(
                      label: 'Correo',
                      value: client.email,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _InfoRow(
                      label: 'Teléfono',
                      value: client.phone,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _InfoRow(
                      label: 'Estado',
                      value: client.status,
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

class _InfoRow
    extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(
      BuildContext context,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style:
            const TextStyle(
              fontWeight:
              FontWeight.bold,
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
