//import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/countdown_provider_4.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/end_drawer.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/pack_comando.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TimerZapperScreen4 extends ConsumerWidget {
  const TimerZapperScreen4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool modoSeleccionado = ref.watch(selectModoProvider);
    final timer = ref.watch(countdownProvider4);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final bluetoothProvider = ref.watch(bleProvider);
    const int tiempoClark = 10;
    const int tiempoRift = 6;
    const int tiempoReposo = 12;

    double porcentajeTimer = ((timer.duration.inSeconds.toDouble() * 100) /
            (timer.estado.contains('Unico') ? tiempoRift : tiempoClark)) /
        100;
    double porcentajeTimerReposo =
        ((timer.duration.inSeconds.toDouble() * 100) / tiempoReposo) / 100;

    final TerapiaTotal terapia = ref.watch(terapiaProvider4);

    const String location = '/timerZapper4';

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        } else if (ref.watch(countdownProvider4).estado == 'FIN') {
          await cerrarTimerScreen(ref);
          if (context.mounted) {
            context.pop();
          }
        } else {
          context.pop();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            ClipPath(
              clipper: TimerScreenCurve(),
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        ref.watch(countdownProvider4).estado.contains('Ciclo')
                            ? azulGradientCurvas()
                            : purpleGradientCurvas()),
                //height: 100,
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                //color: Colors.blue.withOpacity(0.3),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          ref.watch(deviceProvider).nombre,
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                actions: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        height: heightScreen * 0.1,
                        width: widthScreen * 0.15,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/icons/icon_circulo.png'))),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        height: heightScreen * 0.1,
                        width: widthScreen * 0.15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: userImage(),
                              onError: (exception, stackTrace) {
                                /* =>
                                  const AssetImage(
                                      'assets/icons/icon_circulo.png') */
                              },
                            )),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(
                      horizontal: widthScreen * 0.008,
                      //vertical: heightScreen * 0.01
                    ),
                    height: heightScreen * 0.06,
                    width: widthScreen * 0.04,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            invertColors: false,
                            fit: BoxFit.fill,
                            image: AssetImage(
                                bluetoothProvider.bleServicesBatery[3]))),
                  )
                ],
              ),
              body: Container(
                height: heightScreen,
                width: widthScreen,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        Container(
                            constraints: BoxConstraints(
                                maxHeight: heightScreen * 0.35,
                                minHeight: heightScreen * 0.35,
                                minWidth: widthScreen * 0.95,
                                maxWidth: widthScreen * 0.95),
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: ref
                                          .watch(countdownProvider4)
                                          .ciclosLeftColor,
                                      offset: const Offset(4, 4),
                                      blurRadius: 15,
                                      spreadRadius: 1),
                                  const BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-4, -4),
                                      blurRadius: 15,
                                      spreadRadius: 1)
                                ]),
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
                                      Text(ref.watch(countdownProvider4).estado,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                      Text(
                                        ref
                                            .watch(countdownProvider4)
                                            .timeLeftString,
                                        style: const TextStyle(fontSize: 50),
                                        textAlign: TextAlign.center,
                                      ),
                                      IconButton(
                                          disabledColor: Colors.transparent,
                                          padding: const EdgeInsets.all(0.0),
                                          iconSize: 50,
                                          onPressed: ref
                                                          .watch(
                                                              countdownProvider4)
                                                          .estado !=
                                                      'FIN' &&
                                                  timer.device.conectado
                                              ? () async {
                                                  modoSeleccionado
                                                      ? timer.startStopTimer(
                                                          'Modo A',
                                                          ref.watch(
                                                              deviceProvider),
                                                          ref.watch(
                                                              terapiaProvider4),
                                                          false)
                                                      : timer.startStopTimer(
                                                          'Modo B',
                                                          ref.watch(
                                                              deviceProvider),
                                                          ref.watch(
                                                              terapiaProvider4),
                                                          false);
                                                  if (timer.isRunning) {
                                                    if (timer.estado
                                                        .contains('Ciclo')) {
                                                      await bluetoothProvider
                                                          .sendCommand(PackComando(
                                                              deviceMac: ref
                                                                  .watch(
                                                                      deviceProvider)
                                                                  .mac,
                                                              comando:
                                                                  listComandos[
                                                                      'play']!,
                                                              terapia: ref.watch(
                                                                  terapiaProvider4)));
                                                    }
                                                  } else {
                                                    await bluetoothProvider
                                                        .sendCommand(PackComando(
                                                            deviceMac: ref
                                                                .watch(
                                                                    deviceProvider)
                                                                .mac,
                                                            comando:
                                                                listComandos[
                                                                    'pause']!,
                                                            terapia: ref.watch(
                                                                terapiaProvider4)));
                                                  }
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
                                      ref.watch(countdownProvider4).estado ==
                                              'FIN'
                                          ? true
                                          : false,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 128),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              gradient:
                                                  purpleGradientVolverButton()),
                                          child: TextButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.transparent)),
                                            onPressed: ref
                                                        .watch(
                                                            countdownProvider4)
                                                        .estado ==
                                                    'FIN'
                                                ? () async {
                                                    await cerrarTimerScreen(
                                                        ref);
                                                    if (context.mounted) {
                                                      context.pop();
                                                    }
                                                  }
                                                : null,
                                            child: const Text(
                                              'VOLVER',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                                    backgroundColor: ref
                                        .watch(countdownProvider4)
                                        .ciclosLeftColor,
                                    color: ref
                                            .watch(countdownProvider4)
                                            .estado
                                            .contains('Ciclo')
                                        ? Colors.blue[50]
                                        : Colors.purple[50],
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(height: 30),
                        TextButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                iconColor:
                                    MaterialStateProperty.all(Colors.white),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.white))),
                            onPressed: () async {
                              ref.read(countdownProvider4).cancelarTimer();
                              await cerrarTimerScreen(ref);
                              if (context.mounted) {
                                context.pop();
                              }
                            },
                            icon: const Icon(Icons.cancel),
                            label: const Text(
                              'Cancelar Terapia',
                              style: TextStyle(color: Colors.white),
                            )),
                        Text(terapia.nombre,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        Text(
                            'Frecuencia: ${terapia.frecMin} KHz - ${terapia.frecMax} KHz',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Container(
                          constraints: BoxConstraints(
                              maxHeight: heightScreen * 0.30,
                              minHeight: heightScreen * 0.30,
                              minWidth: widthScreen * 0.95,
                              maxWidth: widthScreen * 0.95),
                          //color: Colors.grey[200],
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textFromFireBase(terapia.info),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 30),

                                /* IconButton(
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
                                        : Icons.play_arrow)), */
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
              /*  bottomNavigationBar: Container(
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
              ), */
              //
            ),
          ],
        ),
      ),
    );
  }

  String textFromFireBase(String info) {
    //Este metodo se creó porque flutter no reconoce los salto de lineas '\n' que vienen de Firebase
    final List<String> listWords = info.split(' ');
    final List<String> listWordsConSaltoDeLinea = [];
    for (var element in listWords) {
      if (element != r'\n') {
        listWordsConSaltoDeLinea.add('$element' ' ');
      } else {
        element == r'\n' ? listWordsConSaltoDeLinea.add('\n') : null;
      }
    }
    return listWordsConSaltoDeLinea.join('');
  }

  Future<void> cerrarTimerScreen(WidgetRef ref) async {
    ref.read(selectModoProvider.notifier).state = false;
    ref.read(indexTerapiaProvider.notifier).state = 0;
    ref.read(terapiaProvider4.notifier).state =
        await ref.read(servicesProvider).getTerapiaSeleccionada(0);
    ref
        .read(relojProvider.notifier)
        .state[ref.read(deviceProvider).relojAsignado] = 'disponible';
    ref.read(deviceProvider.notifier).state.relojAsignado = 0;
    await ref.read(servicesProvider).editDevice(ref.read(deviceProvider));
    ref.invalidate(servicesProvider);
  }
}

/* class MyPainter extends CustomPainter {
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
} */
