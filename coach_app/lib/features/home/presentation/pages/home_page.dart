/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: home_page.dart
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';

import '../../../calendar/presentation/pages/calendar_page.dart';
import '../../../messages/presentation/pages/messages_page.dart';

import '../providers/home_profile_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  List<Widget> get _pages => const [
    _HomeContent(),
    CalendarPage(),
    MessagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: 'Coach',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              context.push(AppRoutes.profile);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: 'Mensajes',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final profile = ref.watch(homeProfileProvider);

    return authState.when(
      data: (user) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(
                  context,
                  user,
                  profile.value,
                ),

                const SizedBox(height: 24),

                _buildNextTrainingCard(),

                const SizedBox(height: 16),

                _buildProgressCard(context),

                const SizedBox(height: 16),

                _buildQuickAccess(),

                const SizedBox(height: 24),

                _buildMotivationCard(),

                const SizedBox(height: 24),

                BaseButton(
                  text: 'Cerrar sesión',
                  icon: Icons.logout_rounded,
                  onPressed: () async {
                    await ref.read(authServiceProvider).signOut();
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (_, _) => const Center(
        child: Text('Error al cargar el usuario'),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, user, Map<String, dynamic>? profile,) {
    final email = user?.email ?? '';

    final profileCompleted =
        profile?['profileCompleted'] == true;

    final active =
        profile?['active'] == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Hola, $email',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 4),

        Text(
          profileCompleted
              ? 'Perfil completo'
              : 'Completa tu perfil',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 6),

        Row(
          children: [

            Icon(
              active
                  ? Icons.verified
                  : Icons.warning_amber_rounded,
              size: 18,
            ),

            const SizedBox(width: 6),

            Text(
              active
                  ? 'Cuenta activa'
                  : 'Cuenta inactiva',
            ),

          ],
        ),

      ],
    );
  }

  Widget _buildNextTrainingCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Próximo entrenamiento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text('Sin entrenamientos programados'),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mi progreso',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const LinearProgressIndicator(
              value: 0,
            ),
            const SizedBox(height: 8),
            Text(
              'Aún no hay progreso disponible',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accesos rápidos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.2,
          children: const [
            Card(
              child: Center(
                child: Text('Rutinas'),
              ),
            ),
            Card(
              child: Center(
                child: Text('Calendario'),
              ),
            ),
            Card(
              child: Center(
                child: Text('Mensajes'),
              ),
            ),
            Card(
              child: Center(
                child: Text('Objetivos'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMotivationCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '"La disciplina vence a la motivación."',
        ),
      ),
    );
  }
}
