import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
            child: Text(
          'Aquí va el Logo o una imagen al inicar la app',
          style: TextStyle(fontSize: 90),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
