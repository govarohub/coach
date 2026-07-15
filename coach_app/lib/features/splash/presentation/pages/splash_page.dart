/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: splash_page.dart
|--------------------------------------------------------------------------
| Splash profesional con animación del logotipo.
|--------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/auth/auth_service.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacityAnimation;

  late final Animation<double> _scaleAnimation;

  late final Animation<Offset> _offsetAnimation;

  static const Duration _splashDuration = Duration(
    seconds: 3,
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: .85,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, .15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    _navigate();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
  
  Future<void> _navigate() async {
    await Future.delayed(
      _splashDuration,
    );
    
    if (!mounted) {
      return;
    }
    
    context.go(
      _nextRoute(),
    );
  }
  
  String _nextRoute() {
    final authService = AuthService();
    
    if (authService.isAuthenticated) {
      return AppRoutes.home;
      }
  return AppRoutes.login;
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _offsetAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/coach_logo_white.png',
                        width: 210,
                      ),
                      const SizedBox(height: 48),
                      const SizedBox(
                        width: 34,
                        height: 34,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}