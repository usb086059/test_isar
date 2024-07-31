import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_notification_services.dart';

class NotificacionScree extends StatelessWidget {
  const NotificacionScree({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await showNotification();
              },
              child: const Text('Notifica'))),
    ));
  }
}
