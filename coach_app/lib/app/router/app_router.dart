/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: app_router.dart
|--------------------------------------------------------------------------
| Configuración principal de GoRouter.
|--------------------------------------------------------------------------
*/

import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.splash,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, _) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, _) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (_, _) => const RegisterPage(),
          ),
          GoRoute(
            path: AppRoutes.home,
            builder: (_, _) => const HomePage(),
            ),
          ],
);