import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificacionScree extends ConsumerWidget {
  const NotificacionScree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await showNotification(ref.watch(deviceProvider).nombre);
              },
              child: const Text('Notifica'))),
    ));
  }
}
