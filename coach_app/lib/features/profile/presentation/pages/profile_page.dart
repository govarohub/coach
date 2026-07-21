import 'package:flutter/material.dart';

final class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    this.isCoach = false,
  });

  final bool isCoach;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isCoach ? 'Perfil del coach' : 'Mi perfil',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _ProfileContent(
            isCoach: isCoach,
          ),
        ),
      ),
    );
  }
}

final class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    this.isCoach = false,
  });

  final bool isCoach;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isCoach ? 'Nombre del coach' : 'Nombre del usuario',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isCoach
                  ? 'coach@coachapp.com'
                  : 'correo@dominio.com',
            ),
            const SizedBox(height: 4),
            Text(
              isCoach
                  ? '+52 555 555 5555'
                  : '+52 000 000 0000',
            ),

            if (isCoach) ...[
              const SizedBox(height: 24),

              const Divider(),

              const SizedBox(height: 16),

              Text(
                'Especialidad',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 8),

              const Text(
                'Entrenamiento Personal',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              const Divider(),

              const SizedBox(height: 16),

              Text(
                'Experiencia',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 8),

              const Text(
                '5 años de experiencia',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              const Divider(),

              const SizedBox(height: 16),

              Text(
                'Tarifa',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 8),

              const Text(
                '\$250 por sesión',
                textAlign: TextAlign.center,
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: null,
                child: Text(
                  isCoach
                      ? 'Editar perfil del coach'
                      : 'Editar perfil',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
