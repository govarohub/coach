/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: register_page.dart
|--------------------------------------------------------------------------
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/auth/auth_exception_mapper.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../../shared/widgets/base_app_bar.dart';
import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/base_scaffold.dart';
import '../providers/register_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(registerLoadingProvider.notifier).state = true;

    try {
      await ref.read(authServiceProvider).register(
            email: _emailController.text,
            password: _passwordController.text,
          );

      await ref.read(authServiceProvider).sendEmailVerification();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Cuenta creada. Revisa tu correo para verificarla.',
          ),
        ),
      );

      context.go(AppRoutes.login);
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
      ref.read(registerLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(registerLoadingProvider);

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Crear cuenta',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese un correo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar contraseña',
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              BaseButton(
                text: 'Crear cuenta',
                isLoading: loading,
                onPressed: _register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}