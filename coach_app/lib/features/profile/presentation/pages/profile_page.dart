import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/auth/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../../data/repositories/firebase_profile_repository.dart';
import '../../data/services/profile_image_storage_service.dart';

final class ProfilePage extends ConsumerWidget  {
  const ProfilePage({
    super.key,
    this.isCoach = false,
  });

  final bool isCoach;

  Future<void> _changeProfilePhoto(
      WidgetRef ref,
      BuildContext context,
      ) async {
    final authService = ref.read(authServiceProvider);

    final user = authService.currentUser;

    if (user == null) {
      return;
    }

    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) {
      return;
    }

    final storage = ProfileImageStorageService();

    final photoUrl = await storage.uploadProfileImage(
      uid: user.uid,
      image: image,
    );

    final repository = FirebaseProfileRepository();

    final provider = ref.read(profileProvider);

    final profile = provider.profile;

    if (profile == null) {
      return;
    }

    final updated = profile.copyWith(
      photoUrl: photoUrl,
      updatedAt: DateTime.now(),
    );

    await repository.updateProfile(updated);

    provider.setProfile(updated);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Fotografía actualizada correctamente.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onEditPhoto: () => _changeProfilePhoto(ref, context),
          ),
        ),
      ),
    );
  }
}

final class _ProfileContent extends ConsumerWidget  {
  const _ProfileContent({
    required this.onEditPhoto,
    this.isCoach = false,
  });

  final bool isCoach;

  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final provider = ref.watch(profileProvider);

    final profile = provider.profile;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundImage: (profile?.photoUrl?.isNotEmpty ?? false)
                  ? NetworkImage(profile!.photoUrl!)
                  : null,
              child: profile?.photoUrl == null
                  ? const Icon(Icons.person, size: 56)
                  : null,
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
                onPressed: onEditPhoto,
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
