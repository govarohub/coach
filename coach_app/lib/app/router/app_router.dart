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
import '../../core/auth/auth_guard.dart';
import '../../features/authentication/presentation/pages/forgot_password_page.dart';
import '../../features/authentication/presentation/pages/email_verification_page.dart';
import '../../features/authentication/presentation/pages/disabled_account_page.dart';
import '../../core/auth/session_state.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,

  initialLocation: AppRoutes.splash,

  redirect: (context, state) async {
    final sessionState = await AuthGuard.sessionState();

    final String location = state.matchedLocation;

    switch (sessionState) {
      case SessionState.loading:
        return location == AppRoutes.splash
            ? null
            : AppRoutes.splash;

      case SessionState.unauthenticated:
        final bool isPublicRoute =
            location == AppRoutes.splash ||
                location == AppRoutes.login ||
                location == AppRoutes.register ||
                location == AppRoutes.forgotPassword;

        return isPublicRoute ? null : AppRoutes.login;

      case SessionState.emailNotVerified:
        return location == AppRoutes.emailVerification
            ? null
            : AppRoutes.emailVerification;

      case SessionState.profileIncomplete:
      // Temporalmente se permitirá Home hasta crear
      // CompleteProfilePage en el siguiente capítulo.
        return location == AppRoutes.home
            ? null
            : AppRoutes.home;

      case SessionState.authenticated:
        if (location == AppRoutes.login ||
            location == AppRoutes.register ||
            location == AppRoutes.forgotPassword ||
            location == AppRoutes.emailVerification ||
            location == AppRoutes.splash) {
          return AppRoutes.home;
        }
        return null;

      case SessionState.disabled:
        return location == AppRoutes.disabledAccount
            ? null
            : AppRoutes.disabledAccount;
    }
  },

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

    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (_, _) => const ForgotPasswordPage(),
      ),

    GoRoute(
      path: AppRoutes.emailVerification,
      builder: (_, _) => const EmailVerificationPage(),
      ),
    GoRoute(
      path: AppRoutes.disabledAccount,
      builder: (_, _) => const DisabledAccountPage(),
    ),
  ],
);
