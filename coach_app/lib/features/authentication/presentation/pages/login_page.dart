/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: login_page.dart
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
import '../providers/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    ref.read(loginLoadingProvider.notifier).state = true;

    try {
      await ref.read(authServiceProvider).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      if (!mounted) {
        return;
      }

      router.go(
        AppRoutes.home,
      );
    } on FirebaseAuthException catch (exception) {
      if (!mounted) {
        return;
      }

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            AuthExceptionMapper.message(exception),
          ),
        ),
      );
    } finally {
      if (mounted) {
        ref.read(loginLoadingProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(loginLoadingProvider);

    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Iniciar sesión',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FlutterLogo(
                    size: 90,
                  ),

                  const SizedBox(height: 40),

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

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _obscurePassword = !_obscurePassword;
                            },
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su contraseña.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  BaseButton(
                    text: 'Iniciar sesión',
                    isLoading: loading,
                    onPressed: _login,
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push(
                          AppRoutes.forgotPassword,
                        );
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Divider(),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      '¿No tienes una cuenta?',
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.push(
                          AppRoutes.register,
                        );
                      },
                      child: const Text(
                        'Crear cuenta',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
