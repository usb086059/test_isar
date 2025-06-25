import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/agregar_terapia.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/editar_terapia.dart';
import 'package:flutter_application_1/eliminar_terapia.dart';
import 'package:flutter_application_1/end_drawer.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/pack_comando.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/countdown_provider_2.dart';
import 'package:flutter_application_1/countdown_provider_3.dart';
import 'package:flutter_application_1/countdown_provider_4.dart';
import 'package:flutter_application_1/countdown_provider_5.dart';
import 'package:flutter_application_1/state_provider.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/comandos.dart';

class HomeZapperScreen extends ConsumerWidget {
  const HomeZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(countdownProvider);
    final timer2 = ref.watch(countdownProvider2);
    final timer3 = ref.watch(countdownProvider3);
    final timer4 = ref.watch(countdownProvider4);
    final timer5 = ref.watch(countdownProvider5);
    final bool modoSeleccionado = ref.watch(selectModoProvider);
    //final int terapiaSeleccionada = ref.watch(indexTerapiaProvider);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final bluetoothProvider = ref.watch(bleProvider);
    ScrollController scroll = ScrollController();
    final int puntero = ref.watch(indexTerapiaProvider);

    final formKey = GlobalKey<FormState>();
    final nombreTerapiaController = TextEditingController();
    final frecMinimaController = TextEditingController();
    final frecMaximaController = TextEditingController();
    final descripcionController = TextEditingController(
        text: 'Agregue una breve descripción de la terapia');
    //final Terapia newTerapia;

    final nombreEditarTerapiaController =
        TextEditingController(text: ref.watch(terapiaProvider0).nombre);
    final frecMinimaEditarTerapiaController = TextEditingController(
        text: ref.watch(terapiaProvider0).frecMin.toString());
    final frecMaximaEditarTerapiaController = TextEditingController(
        text: ref.watch(terapiaProvider0).frecMax.toString());
    final descripcionEditarTerapiaController =
        TextEditingController(text: ref.watch(terapiaProvider0).info);

    final String location = '/homeZapper';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          ClipPath(
            clipper: LoginCurve(),
            child: Container(
              decoration: BoxDecoration(gradient: purpleGradientCurvas()),
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
                    /* Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(user!.photoURL!)),
                    ), */
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              actions: [
                Stack(children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    height: heightScreen * 0.1,
                    width: widthScreen * 0.15,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/icons/icon_circulo.png'))),
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
                ]),
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
                          image: AssetImage(bluetoothProvider
                              .getBatteryLevel(ref.read(deviceProvider).mac)))),
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
                      top: 8, bottom: 16, left: 16, right: 16),
                  child: Column(
                    children: [
                      const Text('MODOS DE APLICACIÓN',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 50, 102, 175),
                              fontWeight: FontWeight.bold)),
                      //const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 11.5, bottom: 30, left: 16, right: 16),
                        decoration: const BoxDecoration(
                            //borderRadius: BorderRadius.circular(45),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/icons/icono9.png'))),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient:
                                  modoSeleccionado ? null : azulGradient(),
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(30, 35))),
                          child: FilledButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                ref.read(selectModoProvider.notifier).state =
                                    false;
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('CONTINUO',
                                      style: TextStyle(
                                          color: modoSeleccionado
                                              ? const Color.fromARGB(
                                                  255, 50, 102, 175)
                                              : Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      '     Un ciclo único que dura 60 minutos ON     ',
                                      style: TextStyle(
                                          color: modoSeleccionado
                                              ? const Color.fromARGB(
                                                  255, 50, 102, 175)
                                              : Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text('y luego finaliza la terapia.',
                                      style: TextStyle(
                                          color: modoSeleccionado
                                              ? const Color.fromARGB(
                                                  255, 50, 102, 175)
                                              : Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 11.5, bottom: 30, left: 16, right: 16),
                        decoration: const BoxDecoration(
                            //borderRadius: BorderRadius.circular(45),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/icons/icono9.png'))),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient:
                                  modoSeleccionado ? azulGradient() : null,
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(30, 35))),
                          child: FilledButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                ref.read(selectModoProvider.notifier).state =
                                    true;
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('POR TANDAS',
                                      style: TextStyle(
                                          color: modoSeleccionado
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 50, 102, 175),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      'Ciclo 1-2 = 7 minutos ON y 20 minutos OFF. ',
                                      style: TextStyle(
                                          color: modoSeleccionado
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 50, 102, 175),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      'Ciclo 3 = 7 minutos ON y termina la terapia.',
                                      style: TextStyle(
                                          color: modoSeleccionado
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 50, 102, 175),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ],
                              )),
                        ),
                      ),
                      Divider(color: Colors.blue[50]),
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'TERAPIAS',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 50, 102, 175),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                              color: const Color.fromARGB(255, 50, 102, 175),
                              disabledColor: Colors.black12,
                              onPressed: !ref.watch(terapiaProvider0).editable
                                  ? null
                                  : () {
                                      eliminarTerapia(context, heightScreen,
                                          widthScreen, ref);
                                    },
                              icon: const Icon(Icons.delete_forever_outlined)),
                          //SizedBox(width: 4),
                          IconButton(
                              color: const Color.fromARGB(255, 50, 102, 175),
                              disabledColor: Colors.black12,
                              onPressed: !ref.watch(terapiaProvider0).editable
                                  ? null
                                  : () {
                                      editarTerapia(
                                          context,
                                          heightScreen,
                                          widthScreen,
                                          formKey,
                                          nombreEditarTerapiaController,
                                          frecMinimaEditarTerapiaController,
                                          frecMaximaEditarTerapiaController,
                                          descripcionEditarTerapiaController,
                                          ref);
                                    },
                              icon: const Icon(Icons.edit_note)),
                          //SizedBox(width: 4),
                          IconButton(
                              color: const Color.fromARGB(255, 50, 102, 175),
                              disabledColor: Colors.black12,
                              onPressed: () {
                                agregarTerapia(
                                    context,
                                    heightScreen,
                                    widthScreen,
                                    formKey,
                                    nombreTerapiaController,
                                    frecMinimaController,
                                    frecMaximaController,
                                    descripcionController,
                                    ref);
                              },
                              icon: const Icon(Icons.add_circle_outline))
                        ],
                      ),
                      //const SizedBox(height: 4),
                      Container(
                          constraints: BoxConstraints(
                              maxHeight: heightScreen * 0.47,
                              maxWidth: widthScreen * 0.95),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: FutureBuilder(
                              future: ref
                                  .watch(servicesProvider)
                                  .getAllTerapiaTotal(), //Carga las terapias de la base local
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  if (ref.watch(origenHomeZapperProvider)) {
                                    //Pregunta si viene de devices_screen
                                    Future(() async {
                                      ref
                                          .read(
                                              origenHomeZapperProvider.notifier)
                                          .state = false;
                                    });
                                  }
                                  return GridView.builder(
                                      controller: scroll,
                                      itemCount: snapshot.data?.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio:
                                                  heightScreen * 0.005,
                                              //crossAxisSpacing: 8,
                                              //mainAxisSpacing: 12,
                                              crossAxisCount: 1),
                                      itemBuilder: (context, index) {
                                        if (ref
                                            .watch(countdownProvider)
                                            .volvioDeTimerZapperScreen) {
                                          ref
                                              .watch(countdownProvider)
                                              .volver(false);
                                          scroll.jumpTo(
                                              scroll.position.minScrollExtent);
                                        }
                                        return CustomTherapy(
                                          name: snapshot.data![index].nombre,
                                          frecMin:
                                              snapshot.data![index].frecMin,
                                          frecMax:
                                              snapshot.data![index].frecMax,
                                          terapiaSel: index,
                                        );
                                      });
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }))),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              alignment: Alignment.center,
              height: 65,
              width: 80,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(97, 62, 161, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              //padding: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.bottomCenter,
                constraints: const BoxConstraints(maxHeight: 56, maxWidth: 56),
                decoration: BoxDecoration(
                    gradient: azulGradientFloatingActionButton(),
                    borderRadius: BorderRadius.circular(100)),
                child: FloatingActionButton(
                  elevation: 0,
                  /*             focusElevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0, */
                  tooltip: 'Siguiente',
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.transparent,
                  // foregroundColor: Colors.transparent,
                  // focusColor: Colors.transparent,
                  // hoverColor: Colors.transparent,
                  onPressed: () async {
                    Device dev = await ref
                        .watch(servicesProvider)
                        .getDevice(ref.watch(deviceProvider).mac);
                    if (dev.conectado) {
                      print('<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>');
                      int relojNumber = 0;
                      relojNumber = ref.watch(relojProvider).indexOf(ref
                          .watch(deviceProvider)
                          .mac); //indexOf devuelve -1 si no encuentra nada
                      print('<<<<<<<<<<<<RelojNumber: $relojNumber');
                      print(
                          '<<<<<<<<<<<<RelojNumber: ${ref.watch(relojProvider)[0]}');
                      if (relojNumber == -1) {
                        relojNumber =
                            ref.watch(relojProvider).indexOf('disponible');
                        if (relojNumber == -1) {
                          //Avisar que No hay reloj disponible
                        } else {
                          ref.read(relojProvider.notifier).state[relojNumber] =
                              ref.watch(deviceProvider).mac;
                          ref
                              .read(deviceProvider.notifier)
                              .state
                              .relojAsignado = relojNumber;
                          await ref
                              .watch(servicesProvider)
                              .editDevice(ref.watch(deviceProvider));
                          //context.push('/timerZapper$relojNumber');
                        }
                      } else {
                        ref.read(deviceProvider.notifier).state.relojAsignado =
                            relojNumber;
                        await ref
                            .watch(servicesProvider)
                            .editDevice(ref.watch(deviceProvider));
                        //context.push('/timerZapper$relojNumber');
                      }
                      print('>>>>>>>>>>>>>RelojNumber: $relojNumber');

                      switch (relojNumber) {
                        case 1:
                          ref.read(terapiaProvider1.notifier).state = await ref
                              .watch(servicesProvider)
                              .getTerapiaSeleccionada(puntero);
                          modoSeleccionado
                              ? timer.startStopTimer(
                                  'Modo A',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider1),
                                  true)
                              : timer.startStopTimer(
                                  'Modo B',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider1),
                                  true);
                          await bluetoothProvider.sendCommand(PackComando(
                              deviceMac: ref.watch(deviceProvider).mac,
                              comando: listComandos['ON']!,
                              terapia: ref.watch(terapiaProvider1)));
                          /* await bluetoothProvider.enviarDataBLE(
                              ref.watch(deviceProvider).mac,
                              listComandos['ON']!,
                              ref.watch(terapiaProvider1)); */
                          /* ref.read(locationProvider.notifier).state =
                              '/timerZapper$relojNumber'; */
                          context.push('/timerZapper$relojNumber');
                        case 2:
                          ref.read(terapiaProvider2.notifier).state = await ref
                              .watch(servicesProvider)
                              .getTerapiaSeleccionada(puntero);
                          modoSeleccionado
                              ? timer2.startStopTimer(
                                  'Modo A',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider2),
                                  true)
                              : timer2.startStopTimer(
                                  'Modo B',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider2),
                                  true);
                          await bluetoothProvider.sendCommand(PackComando(
                              deviceMac: ref.watch(deviceProvider).mac,
                              comando: listComandos['ON']!,
                              terapia: ref.watch(terapiaProvider2)));
                          /* await bluetoothProvider.enviarDataBLE(
                              ref.watch(deviceProvider).mac,
                              listComandos['ON']!,
                              ref.watch(terapiaProvider2)); */
                          context.push('/timerZapper$relojNumber');
                        case 3:
                          ref.read(terapiaProvider3.notifier).state = await ref
                              .watch(servicesProvider)
                              .getTerapiaSeleccionada(puntero);
                          modoSeleccionado
                              ? timer3.startStopTimer(
                                  'Modo A',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider3),
                                  true)
                              : timer3.startStopTimer(
                                  'Modo B',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider3),
                                  true);
                          await bluetoothProvider.sendCommand(PackComando(
                              deviceMac: ref.watch(deviceProvider).mac,
                              comando: listComandos['ON']!,
                              terapia: ref.watch(terapiaProvider3)));
                          /* await bluetoothProvider.enviarDataBLE(
                              ref.watch(deviceProvider).mac,
                              listComandos['ON']!,
                              ref.watch(terapiaProvider3)); */
                          context.push('/timerZapper$relojNumber');
                        case 4:
                          ref.read(terapiaProvider4.notifier).state = await ref
                              .watch(servicesProvider)
                              .getTerapiaSeleccionada(puntero);
                          modoSeleccionado
                              ? timer4.startStopTimer(
                                  'Modo A',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider4),
                                  true)
                              : timer4.startStopTimer(
                                  'Modo B',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider4),
                                  true);
                          await bluetoothProvider.sendCommand(PackComando(
                              deviceMac: ref.watch(deviceProvider).mac,
                              comando: listComandos['ON']!,
                              terapia: ref.watch(terapiaProvider4)));
                          /* await bluetoothProvider.enviarDataBLE(
                              ref.watch(deviceProvider).mac,
                              listComandos['ON']!,
                              ref.watch(terapiaProvider4)); */
                          context.push('/timerZapper$relojNumber');
                        case 5:
                          ref.read(terapiaProvider5.notifier).state = await ref
                              .watch(servicesProvider)
                              .getTerapiaSeleccionada(puntero);
                          modoSeleccionado
                              ? timer5.startStopTimer(
                                  'Modo A',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider5),
                                  true)
                              : timer5.startStopTimer(
                                  'Modo B',
                                  ref.watch(deviceProvider),
                                  ref.watch(terapiaProvider5),
                                  true);
                          await bluetoothProvider.sendCommand(PackComando(
                              deviceMac: ref.watch(deviceProvider).mac,
                              comando: listComandos['ON']!,
                              terapia: ref.watch(terapiaProvider5)));
                          /* await bluetoothProvider.enviarDataBLE(
                              ref.watch(deviceProvider).mac,
                              listComandos['ON']!,
                              ref.watch(terapiaProvider5)); */
                          context.push('/timerZapper$relojNumber');
                      }
                    } else {
                      print(
                          '<<<<<<<<<<<<<< DeviveProvider desconectado >>>>>>>>>>>>>>');
                    }
                  },
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ],
      ),
    );
  }
}

class CustomTherapy extends ConsumerWidget {
  final String name;
  final int frecMin;
  final int frecMax;
  final int terapiaSel;

  const CustomTherapy(
      {Key? key,
      required this.name,
      required this.frecMin,
      required this.frecMax,
      required this.terapiaSel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final int ter = ref.watch(indexTerapiaProvider);
    return Container(
      //color: Colors.green,
      padding: const EdgeInsets.only(top: 10, bottom: 26, left: 16, right: 16),
      decoration: const BoxDecoration(
          //borderRadius: BorderRadius.circular(45),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/icons/icono9.png'))),
      child: Container(
        decoration: BoxDecoration(
            gradient: ref.watch(indexTerapiaProvider) == terapiaSel
                ? azulGradient()
                : null,
            borderRadius: const BorderRadius.all(Radius.elliptical(27, 23))),
        child: FilledButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
            onPressed: () async {
              ref.read(indexTerapiaProvider.notifier).state = terapiaSel;
              ref.read(terapiaProvider0.notifier).state = await ref
                  .watch(servicesProvider)
                  .getTerapiaSeleccionada(terapiaSel);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name,
                    style: TextStyle(
                        color: ref.watch(indexTerapiaProvider) == terapiaSel
                            ? Colors.white
                            : const Color.fromARGB(255, 50, 102, 175),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text('$frecMin KHz - $frecMax KHz',
                    style: TextStyle(
                        color: ref.watch(indexTerapiaProvider) == terapiaSel
                            ? Colors.white
                            : const Color.fromARGB(255, 50, 102, 175),
                        fontSize: 12,
                        fontWeight: FontWeight.bold))
              ],
            )),
      ),
    );
  }
}
