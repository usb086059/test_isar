import 'package:flutter_application_1/ble_screen.dart';
import 'package:flutter_application_1/curva_screem.dart';
import 'package:flutter_application_1/home_zapper_screen.dart';
import 'package:flutter_application_1/notificaciones_screen.dart';
import 'package:flutter_application_1/register_screen.dart';
import 'package:flutter_application_1/screens.dart';
import 'package:flutter_application_1/devices_screen.dart';
import 'package:flutter_application_1/timer_zapper_screen1.dart';
import 'package:flutter_application_1/timer_zapper_screen2.dart';
import 'package:flutter_application_1/timer_zapper_screen3.dart';
import 'package:flutter_application_1/timer_zapper_screen4.dart';
import 'package:flutter_application_1/timer_zapper_screen5.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/devices',
      builder: (context, state) => const DevicesScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/bluetooth',
      builder: (context, state) => const BleScreen(),
    ),
    GoRoute(
      path: '/homeZapper',
      builder: (context, state) => const HomeZapperScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/timerZapper1',
      builder: (context, state) => const TimerZapperScreen1(),
    ),
    GoRoute(
      path: '/timerZapper2',
      builder: (context, state) => const TimerZapperScreen2(),
    ),
    GoRoute(
      path: '/timerZapper3',
      builder: (context, state) => const TimerZapperScreen3(),
    ),
    GoRoute(
      path: '/timerZapper4',
      builder: (context, state) => const TimerZapperScreen4(),
    ),
    GoRoute(
      path: '/timerZapper5',
      builder: (context, state) => const TimerZapperScreen5(),
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
