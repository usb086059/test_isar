import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app_router.dart';
import 'package:flutter_application_1/local_notification_services.dart';
//import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Services().db;

  await Services().terapiasIniciales();
  await Services().cargarTerapiaTotal();

  await initNotification();
  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //final Dato newDato = Dato(name: 'newDato');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
