/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: forgot_password_page.dart
|--------------------------------------------------------------------------
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_exception_mapper.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../providers/forgot_password_provider.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  ConsumerState<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(forgotPasswordLoadingProvider.notifier).state = true;

    try {
      await ref.read(authServiceProvider).sendPasswordReset(
            email: _emailController.text,
          );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Se envió un correo para restablecer tu contraseña.',
          ),
        ),
      );

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (exception) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AuthExceptionMapper.message(exception),
          ),
        ),
      );
    } finally {
      ref.read(forgotPasswordLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(
      forgotPasswordLoadingProvider,
    );

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Recuperar contraseña',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese su correo.';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              BaseButton(
                text: 'Enviar correo',
                isLoading: loading,
                onPressed: _sendEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}