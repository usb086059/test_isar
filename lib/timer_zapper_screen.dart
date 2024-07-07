//import 'dart:ffi' as ffi;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/state_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TimerZapperScreen extends ConsumerWidget {
  const TimerZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool modoSeleccionado = ref.watch(selectModoProvider);
    final timer = ref.watch(countdownProvider);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    final int tiempoClark = 10;
    final int tiempoRift = 6;
    final int tiempoReposo = 12;

    double porcentajeTimer = ((timer.duration.inSeconds.toDouble() * 100) /
            (timer.estado.contains('Unico') ? tiempoRift : tiempoClark)) /
        100;
    double porcentajeTimerReposo =
        ((timer.duration.inSeconds.toDouble() * 100) / tiempoReposo) / 100;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        } else if (ref.watch(countdownProvider).estado != 'FIN') {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.blue,
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    title: const Text(
                      'AVISO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    content: Container(
                      constraints: BoxConstraints(
                          maxHeight: heightScreen * 0.17,
                          maxWidth: widthScreen * 0.95),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Intenta volver al menú de terapias. Si vuelve, se cancelará la terapia actual.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '¿Quiere cancelar la terapia actual?',
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    actions: [
                      TextButton(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(BorderSide(
                            color: Colors.white,
                          ))),
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          )),
                      TextButton(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(BorderSide(
                            color: Colors.white,
                          ))),
                          onPressed: () {
                            ref.read(selectModoProvider.notifier).state = false;
                            ref.read(indexTerapiaProvider.notifier).state = 0;
                            ref.watch(countdownProvider).terminarTimer();
                            context.pop();
                            context.pop();
                          },
                          child: const Text('Sí',
                              style: TextStyle(color: Colors.white)))
                    ],
                  ));
        } else {
          ref.read(selectModoProvider.notifier).state = false;
          ref.read(indexTerapiaProvider.notifier).state = 0;
          ref.watch(countdownProvider).terminarTimer();
          context.pop();
        }
      },
      child: MaterialApp(
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
              'ZAPPER',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 16, left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                      //height: 100,
                      //width: 200,
                      constraints: BoxConstraints(
                          maxHeight: heightScreen * 0.35,
                          minHeight: heightScreen * 0.35,
                          minWidth: widthScreen * 0.95,
                          maxWidth: widthScreen * 0.95),
                      //color: Colors.grey[200],
                      child: Stack(
                        children: [
                          Center(
                            /* top: ((heightScreen * 0.35) / 2) - 35,
                              left: ((widthScreen * 0.95) / 4),
                              right: ((widthScreen * 0.95) / 4), */
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Text(ref.watch(countdownProvider).estado,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                Text(
                                  ref.watch(countdownProvider).timeLeftString,
                                  style: const TextStyle(fontSize: 50),
                                  textAlign: TextAlign.center,
                                ),
                                IconButton(
                                    disabledColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0.0),
                                    iconSize: 50,
                                    onPressed: ref
                                                .watch(countdownProvider)
                                                .estado !=
                                            'FIN'
                                        ? () {
                                            modoSeleccionado
                                                ? timer.startStopTimer('Modo A')
                                                : timer
                                                    .startStopTimer('Modo B');
                                          }
                                        : null,
                                    icon: Icon(timer.isRunning
                                        ? Icons.pause
                                        : Icons.play_arrow)),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                ref.watch(countdownProvider).estado == 'FIN'
                                    ? true
                                    : false,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 128),
                                  TextButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blue)),
                                    onPressed: ref
                                                .watch(countdownProvider)
                                                .estado ==
                                            'FIN'
                                        ? () {
                                            ref
                                                .read(
                                                    selectModoProvider.notifier)
                                                .state = false;
                                            ref
                                                .read(indexTerapiaProvider
                                                    .notifier)
                                                .state = 0;
                                            ref
                                                .watch(countdownProvider)
                                                .terminarTimer();
                                            context.pop();
                                          }
                                        : null,
                                    child: const Text(
                                      'VOLVER',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              strokeAlign: 12,
                              strokeWidth: 16,
                              strokeCap: StrokeCap.butt,
                              value: timer.estado.contains('Reposo')
                                  ? porcentajeTimerReposo
                                  : porcentajeTimer,
                              backgroundColor:
                                  ref.watch(countdownProvider).ciclosLeftColor,
                              color: Colors.blue[50],
                            ),
                          )
                        ],
                      )),
                  const SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.5,
                        minHeight: heightScreen * 0.5,
                        minWidth: widthScreen * 0.95,
                        maxWidth: widthScreen * 0.95),
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              ref.watch(countdownProvider).setCountdownDuration(
                                  Duration(seconds: tiempoClark));
                            },
                            icon: const Icon(Icons.restart_alt)),
                        Text('data ${timer.isRunning}'),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {
                              modoSeleccionado
                                  ? timer.startStopTimer('Modo A')
                                  : timer.startStopTimer('Modo B');
                            },
                            icon: Icon(timer.isRunning
                                ? Icons.pause
                                : Icons.play_arrow)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          /*  floatingActionButton: FloatingActionButton(
              //elevation: 3,
              tooltip: 'Siguiente',
              shape: const StadiumBorder(),
              backgroundColor: Colors.blue,
            
              onPressed: () {
                timer.startStopTimer();
              },
              child: Icon(
                timer.isRunning ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ), 
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
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
          ),
          //
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width,
        height: size.height);
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.5), size.width * 0.4, paint);

    canvas.drawArc(rect, pi, pi / 2, false, paint);
    canvas.drawArc(rect, pi / 3, pi / 2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
