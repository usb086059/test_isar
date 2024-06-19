import 'package:flutter_application_1/register_screen.dart';
import 'package:flutter_application_1/screens.dart';
import 'package:flutter_application_1/splash_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    /* GoRoute(
      path: '/bluetooth',
      builder: (context, state) => const HomeScreen(),
    ), */
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    /* GoRoute(
      path: '/timer',
      builder: (context, state) => const RegisterScreen(),
    ) */
  ],
);
