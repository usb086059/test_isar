import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerZapperScreen extends ConsumerWidget {
  const TimerZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL!))),
            centerTitle: true,
            title: const Text(
              'RELOJ',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 1])),
            ),
          ),
          body: const Placeholder(),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.blue, Colors.white],
                    stops: [0.01, 0.8])),
            child: BottomAppBar(
              height: heightScreen * 0.05,
              color: Colors.transparent,
              notchMargin: 4,
              shape: const CircularNotchedRectangle(),
            ),
          )),
    );
  }
}
