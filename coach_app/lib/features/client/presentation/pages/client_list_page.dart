import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_scaffold.dart';

import '../../domain/models/client.dart';
import '../providers/client_provider.dart';

import 'client_detail_page.dart';
import 'client_form_page.dart';

class ClientListPage extends ConsumerWidget {
  const ClientListPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final clients = ref.watch(
      clientProvider,
    );

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Clientes',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ClientFormPage(),
            ),
          );

          ref.invalidate(
            clientProvider,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: clients.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (
            error,
            stackTrace,
            ) =>
        const Center(
          child: Text(
            'No fue posible cargar los clientes.',
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'No hay clientes registrados.',
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (
                context,
                index,
                ) =>
            const SizedBox(
              height: 12,
            ),
            itemBuilder: (
                context,
                index,
                ) {
              final client = items[index];

              return InkWell(
                borderRadius:
                BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          ClientDetailPage(
                            clientId: client.id,
                          ),
                    ),
                  );
                },
                child: _ClientCard(
                  client: client,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  const _ClientCard({
    required this.client,
  });

  final Client client;

  @override
  Widget build(
      BuildContext context,
      ) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              '${client.firstName} ${client.lastName}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              client.email,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 18,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  client.phone,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Chip(
              label: Text(
                client.status,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
