import 'package:flutter_application_1/curva_screem.dart';
import 'package:flutter_application_1/home_zapper_screen.dart';
import 'package:flutter_application_1/notificaciones_screen.dart';
import 'package:flutter_application_1/register_screen.dart';
import 'package:flutter_application_1/screens.dart';
import 'package:flutter_application_1/devices_screen.dart';
import 'package:flutter_application_1/timer_zapper_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/devices',
      builder: (context, state) => const DevicesScreen(),
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
      path: '/homeZapper',
      builder: (context, state) => const HomeZapperScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/timerZapper',
      builder: (context, state) => const TimerZapperScreen(),
    ),
    GoRoute(
      path: '/curvaScreen',
      builder: (context, state) => const CurvaScreen(),
    ),
    GoRoute(
      path: '/notificacionScreen',
      builder: (context, state) => const NotificacionScree(),
    ),
  ],
);
