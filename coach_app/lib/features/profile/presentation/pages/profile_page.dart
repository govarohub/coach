import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/auth/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../../data/services/profile_image_storage_service.dart';

import '../../domain/models/profile.dart';
import '../widgets/profile_form.dart';


final class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({
    super.key,
    this.isCoach = false,
  });

  final bool isCoach;

  @override
  ConsumerState<ProfilePage> createState() =>
      _ProfilePageState();
}

final class _ProfilePageState
    extends ConsumerState<ProfilePage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final authService =
      ref.read(authServiceProvider);

      final user = authService.currentUser;

      if (user == null) {
        return;
      }

      await ref
          .read(profileProvider)
          .loadProfile(user.uid);
    });
  }

  Future<void> _changeProfilePhoto(
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


    final provider = ref.read(profileProvider);

    final profile = provider.profile;

    // Todavía no existe un perfil creado.
    if (profile == null) {
      return;
    }

    final updated = profile.copyWith(
      photoUrl: photoUrl,
      updatedAt: DateTime.now(),
    );

    await provider.updatePhoto(updated);

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
  Widget build(BuildContext context) {

    final provider = ref.watch(profileProvider);

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final profile = provider.profile;

    final user =
        ref.read(authServiceProvider).currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No hay un usuario autenticado.',
          ),
        ),
      );
    }

    final initialProfile = profile ??
        Profile(
          uid: user.uid,
          email: user.email ?? '',
          firstName: '',
          lastName: '',
          phone: '',
          isCoach: widget.isCoach,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isCoach
              ? 'Perfil del coach'
              : 'Mi perfil',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _ProfileContent(
            profile: initialProfile,
            isCoach: widget.isCoach,
            isLoading: provider.isLoading,
            onEditPhoto: () => _changeProfilePhoto(context),
          ),
        ),
      ),
    );
  }
}

final class _ProfileContent extends ConsumerWidget  {

  const _ProfileContent({
    required this.profile,
    required this.onEditPhoto,
    required this.isLoading,
    this.isCoach = false,
  });

  final bool isCoach;

  final bool isLoading;

  final Profile? profile;

  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref,) {

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onEditPhoto,
              child: Stack(
                alignment: Alignment.bottomRight,
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
                  const CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: ProfileForm(
                  profile: profile!,
                  isLoading: isLoading,
                  buttonText: 'Guardar cambios',
                  onSave: (updatedProfile) async {
                    try {
                      final provider = ref.read(profileProvider);

                      await provider.saveProfile(updatedProfile);

                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Perfil guardado correctamente.',
                          ),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                             'No fue posible guardar el perfil.\n$e',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
