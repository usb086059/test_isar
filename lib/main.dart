import 'package:flutter/material.dart';
import 'package:flutter_application_1/dato.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services().db;
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final Dato newDato = Dato(name: 'newDato');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () {}, child: const Text('DELETE')),
          TextButton(
              onPressed: () {
                ref.watch(servicesProvider).addDato(newDato);
              },
              child: const Text('ADD')),
          TextButton(onPressed: () {}, child: const Text('GET ALL')),
        ],
      ),
    )));
  }
}
