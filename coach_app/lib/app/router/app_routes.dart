/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: app_routes.dart
|--------------------------------------------------------------------------
| Definición centralizada de rutas de la aplicación.
|--------------------------------------------------------------------------
*/

final class AppRoutes {
  AppRoutes._();

  // Splash
  static const String splash = '/';

  // Autenticación
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String emailVerification = '/email-verification';
  static const String disabledAccount = '/disabled-account';
  static const String selectProfile = '/select-profile';

  // Inicio
  static const String home = '/home';

  // Usuario
  static const String userProfile = '/user/profile';
  static const String userReservations = '/user/reservations';
  static const String userCalendar = '/user/calendar';
  static const String userMap = '/user/map';

  // Coach
  static const String coachProfile = '/coach/profile';
  static const String coachAvailability = '/coach/availability';
  static const String coachReservations = '/coach/reservations';
  static const String coachSchedule = '/coach/schedule';

  // Configuración
  static const String settings = '/settings';

  // Pagos
  static const String payments = '/payments';
  static const String paymentHistory = '/payments/history';

  // Administración
  static const String admin = '/admin';
}
