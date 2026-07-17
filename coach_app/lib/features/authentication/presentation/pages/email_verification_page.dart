/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: email_verification_page.dart
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
import '../providers/email_verification_provider.dart';

class EmailVerificationPage extends ConsumerWidget {
  const EmailVerificationPage({
    super.key,
  });

  Future<void> _reloadUser(
    WidgetRef ref,
    BuildContext context,
  ) async {
    ref.read(emailVerificationLoadingProvider.notifier).state = true;

    await ref.read(authServiceProvider).reloadUser();

    final verified = ref.read(authServiceProvider).isEmailVerified;

    ref.read(emailVerificationLoadingProvider.notifier).state = false;

    if (!context.mounted) {
      return;
    }

    if (verified) {
      context.go(AppRoutes.splash);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Tu correo aún no ha sido verificado.',
        ),
      ),
    );
  }

  Future<void> _sendVerification(
    WidgetRef ref,
    BuildContext context,
  ) async {
    ref.read(emailVerificationLoadingProvider.notifier).state = true;

    await ref.read(authServiceProvider).sendEmailVerification();

    ref.read(emailVerificationLoadingProvider.notifier).state = false;

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Correo de verificación enviado.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(
      emailVerificationLoadingProvider,
    );

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Verificar correo',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_read_outlined,
              size: 90,
            ),
            const SizedBox(height: 24),
            const Text(
              'Revisa tu correo electrónico y confirma tu cuenta antes de continuar.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            BaseButton(
              text: 'Ya verifiqué mi correo',
              isLoading: loading,
              onPressed: () => _reloadUser(
                ref,
                context,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: loading
                  ? null
                  : () => _sendVerification(
                        ref,
                        context,
                      ),
              child: const Text(
                'Reenviar correo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
