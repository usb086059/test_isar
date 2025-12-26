import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/agregar_terapia.dart';
import 'package:flutter_application_1/auth_provider.dart';
import 'package:flutter_application_1/aviso_error_conexion.dart';
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

    final isEnabledButtonPlay = ref.watch(isEnabledButtonPlayProvider);

    final isLoadingTerapiaTotaleProvider = ref.watch(isLoadingTerapiaTotale);

    // 1. 💡 LÓGICA DE ESCUCHA Y EFECTO SECUNDARIO SEGURO
    // Usamos watch para que el widget se reconstruya si el Provider cambia a true.
    if (ref.watch(isComingFromSomeTimerScreen)) {
      // Programamos la ejecución para la Microtask Queue.
      // Esto se ejecuta inmediatamente después de que el build termine,
      // fuera del ciclo de dibujo activo.
      Future.microtask(() {
        // Primero, aseguramos el estado del widget antes de cualquier acción (buena práctica)
        if (!context.mounted) return;

        // 1. Ejecutar la acción imperativa (Scroll)
        // Esto solo se ejecuta una vez por ciclo cuando el Provider es true.
        scroll.jumpTo(scroll.position.minScrollExtent);

        // 2. Restablecer el Provider (Side Effect/Cambio de Estado)
        // Esto disparará una nueva reconstrucción donde el IF ya será false.
        ref.read(isComingFromSomeTimerScreen.notifier).state = false;
      });
    }

    final imagePath = ref.watch(userImageProvider);

    final double systemNavigationBarHeight =
        MediaQuery.of(context).viewPadding.bottom;
    print('>>>>>>>>>>>>>>>>> bottomSystemBar = $systemNavigationBarHeight');

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        } else {
          context.pop();
        }
      },
      child: SafeArea(
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: MaterialApp(
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
                  actionsPadding: const EdgeInsets.only(bottom: 4),
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
                              image: userImage(imagePath),
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
                              image: AssetImage(
                                  bluetoothProvider.getBatteryLevel(
                                      ref.read(deviceProvider).mac)))),
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
                                    image:
                                        AssetImage('assets/icons/icono9.png'))),
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
                                    ref
                                        .read(selectModoProvider.notifier)
                                        .state = false;
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
                                    image:
                                        AssetImage('assets/icons/icono9.png'))),
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
                                    ref
                                        .read(selectModoProvider.notifier)
                                        .state = true;
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
                                  color:
                                      const Color.fromARGB(255, 50, 102, 175),
                                  disabledColor: Colors.black12,
                                  onPressed:
                                      !ref.watch(terapiaProvider0).editable
                                          ? null
                                          : () {
                                              eliminarTerapia(
                                                  context,
                                                  heightScreen,
                                                  widthScreen,
                                                  ref);
                                            },
                                  icon: const Icon(
                                      Icons.delete_forever_outlined)),
                              //SizedBox(width: 4),
                              IconButton(
                                  color:
                                      const Color.fromARGB(255, 50, 102, 175),
                                  disabledColor: Colors.black12,
                                  onPressed:
                                      !ref.watch(terapiaProvider0).editable
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
                                  color:
                                      const Color.fromARGB(255, 50, 102, 175),
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
                                  maxHeight: heightScreen * 0.47 -
                                      systemNavigationBarHeight,
                                  maxWidth: widthScreen * 0.95),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: FutureBuilder(
                                  future: ref
                                      .watch(servicesProvider)
                                      .getAllTerapiaTotal(), //Carga las terapias de la base local
                                  builder: ((context, snapshot) {
                                    if (snapshot.hasData) {
                                      /*  ref
                                          .read(isLoadingTerapiaTotale.notifier)
                                          .state = false; */
                                      if (snapshot.data!.length > 0) {
                                        if (ref
                                            .watch(origenHomeZapperProvider)) {
                                          //Pregunta si viene de devices_screen
                                          Future(() async {
                                            ref
                                                .read(origenHomeZapperProvider
                                                    .notifier)
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
                                              /* if (ref.watch(
                                                  isComingFromSomeTimerScreen)) {
                                                print(
                                                    '------------- deviceProvider es = ${ref.read(deviceProvider).relojAsignado}');
                                                ref
                                                    .read(
                                                        isComingFromSomeTimerScreen
                                                            .notifier)
                                                    .state = false;
                                                scroll.jumpTo(scroll
                                                    .position.minScrollExtent);
                                              } */
                                              return CustomTherapy(
                                                name: snapshot
                                                    .data![index].nombre,
                                                frecMin: snapshot
                                                    .data![index].frecMin,
                                                frecMax: snapshot
                                                    .data![index].frecMax,
                                                terapiaSel: index,
                                              );
                                            });
                                      } else {
                                        return Stack(children: [
                                          Visibility(
                                            visible:
                                                !isLoadingTerapiaTotaleProvider,
                                            child: Center(
                                              child: TextButton.icon(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              const Color.fromARGB(
                                                                  255,
                                                                  50,
                                                                  102,
                                                                  175)),
                                                      iconColor:
                                                          MaterialStateProperty.all(
                                                              Colors.white),
                                                      side: MaterialStateProperty.all(
                                                          const BorderSide(
                                                              color: Colors
                                                                  .white))),
                                                  onPressed:
                                                      isLoadingTerapiaTotaleProvider
                                                          ? null
                                                          : () async {
                                                              ref
                                                                  .read(isLoadingTerapiaTotale
                                                                      .notifier)
                                                                  .state = true;
                                                              await Services()
                                                                  .cargarTerapiaTotal();
                                                            },
                                                  icon:
                                                      const Icon(Icons.download),
                                                  label: const Text(
                                                    'Cargar lista de terapias',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                isLoadingTerapiaTotaleProvider,
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        ]);
                                      }
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
                    constraints:
                        const BoxConstraints(maxHeight: 56, maxWidth: 56),
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
                      backgroundColor: isEnabledButtonPlay
                          ? Colors.transparent
                          : Colors.black12,
                      // foregroundColor: Colors.transparent,
                      // focusColor: Colors.transparent,
                      // hoverColor: Colors.transparent,
                      onPressed: isEnabledButtonPlay
                          ? () async {
                              ref
                                  .read(isEnabledButtonPlayProvider.notifier)
                                  .state = false;
                              if (!context.mounted) return;
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: const Color.fromARGB(
                                          255, 50, 102, 175),
                                      backgroundColor: Colors.purple[300],
                                    ));
                                  });
                              Device dev = await ref
                                  .read(servicesProvider)
                                  .getDevice(ref.read(deviceProvider).mac);
                              if (dev.conectado) {
                                print('<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>');
                                int relojNumber = 0;
                                relojNumber = ref.read(relojProvider).indexOf(ref
                                    .read(deviceProvider)
                                    .mac); //indexOf devuelve -1 si no encuentra nada
                                print('<<<<<<<<<<<<RelojNumber: $relojNumber');
                                print(
                                    '<<<<<<<<<<<<RelojNumber: ${ref.watch(relojProvider)[0]}');
                                if (relojNumber == -1) {
                                  relojNumber = ref
                                      .read(relojProvider)
                                      .indexOf('disponible');
                                  if (relojNumber == -1) {
                                    //Avisar que No hay reloj disponible
                                  } else {
                                    ref
                                            .read(relojProvider.notifier)
                                            .state[relojNumber] =
                                        ref.read(deviceProvider).mac;
                                    ref
                                        .read(deviceProvider.notifier)
                                        .state
                                        .relojAsignado = relojNumber;
                                    await ref
                                        .read(servicesProvider)
                                        .editDevice(ref.read(deviceProvider));
                                    ref.invalidate(servicesProvider);
                                    //context.push('/timerZapper$relojNumber');
                                  }
                                } else {
                                  ref
                                      .read(deviceProvider.notifier)
                                      .state
                                      .relojAsignado = relojNumber;
                                  await ref
                                      .read(servicesProvider)
                                      .editDevice(ref.read(deviceProvider));
                                  ref.invalidate(servicesProvider);
                                  //context.push('/timerZapper$relojNumber');
                                }
                                print('>>>>>>>>>>>>>RelojNumber: $relojNumber');

                                switch (relojNumber) {
                                  case 1:
                                    ref.read(terapiaProvider1.notifier).state =
                                        await ref
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
                                    await bluetoothProvider.sendCommand(
                                        PackComando(
                                            deviceMac:
                                                ref.watch(deviceProvider).mac,
                                            comando: listComandos['ON']!,
                                            terapia:
                                                ref.watch(terapiaProvider1)));
                                    /* await bluetoothProvider.enviarDataBLE(
                                  ref.watch(deviceProvider).mac,
                                  listComandos['ON']!,
                                  ref.watch(terapiaProvider1)); */
                                    /* ref.read(locationProvider.notifier).state =
                                  '/timerZapper$relojNumber'; */
                                    ref
                                        .read(isEnabledButtonPlayProvider
                                            .notifier)
                                        .state = true;
                                    if (!context.mounted) return;
                                    context.pop();
                                    context.push('/timerZapper$relojNumber');
                                  case 2:
                                    ref.read(terapiaProvider2.notifier).state =
                                        await ref
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
                                    await bluetoothProvider.sendCommand(
                                        PackComando(
                                            deviceMac:
                                                ref.watch(deviceProvider).mac,
                                            comando: listComandos['ON']!,
                                            terapia:
                                                ref.watch(terapiaProvider2)));
                                    /* await bluetoothProvider.enviarDataBLE(
                                  ref.watch(deviceProvider).mac,
                                  listComandos['ON']!,
                                  ref.watch(terapiaProvider2)); */
                                    ref
                                        .read(isEnabledButtonPlayProvider
                                            .notifier)
                                        .state = true;
                                    if (!context.mounted) return;
                                    context.pop();
                                    context.push('/timerZapper$relojNumber');
                                  case 3:
                                    ref.read(terapiaProvider3.notifier).state =
                                        await ref
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
                                    await bluetoothProvider.sendCommand(
                                        PackComando(
                                            deviceMac:
                                                ref.watch(deviceProvider).mac,
                                            comando: listComandos['ON']!,
                                            terapia:
                                                ref.watch(terapiaProvider3)));
                                    /* await bluetoothProvider.enviarDataBLE(
                                  ref.watch(deviceProvider).mac,
                                  listComandos['ON']!,
                                  ref.watch(terapiaProvider3)); */
                                    ref
                                        .read(isEnabledButtonPlayProvider
                                            .notifier)
                                        .state = true;
                                    if (!context.mounted) return;
                                    context.pop();
                                    context.push('/timerZapper$relojNumber');
                                  case 4:
                                    ref.read(terapiaProvider4.notifier).state =
                                        await ref
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
                                    await bluetoothProvider.sendCommand(
                                        PackComando(
                                            deviceMac:
                                                ref.watch(deviceProvider).mac,
                                            comando: listComandos['ON']!,
                                            terapia:
                                                ref.watch(terapiaProvider4)));
                                    /* await bluetoothProvider.enviarDataBLE(
                                  ref.watch(deviceProvider).mac,
                                  listComandos['ON']!,
                                  ref.watch(terapiaProvider4)); */
                                    ref
                                        .read(isEnabledButtonPlayProvider
                                            .notifier)
                                        .state = true;
                                    if (!context.mounted) return;
                                    context.pop();
                                    context.push('/timerZapper$relojNumber');
                                  case 5:
                                    ref.read(terapiaProvider5.notifier).state =
                                        await ref
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
                                    await bluetoothProvider.sendCommand(
                                        PackComando(
                                            deviceMac:
                                                ref.watch(deviceProvider).mac,
                                            comando: listComandos['ON']!,
                                            terapia:
                                                ref.watch(terapiaProvider5)));
                                    /* await bluetoothProvider.enviarDataBLE(
                                  ref.watch(deviceProvider).mac,
                                  listComandos['ON']!,
                                  ref.watch(terapiaProvider5)); */
                                    ref
                                        .read(isEnabledButtonPlayProvider
                                            .notifier)
                                        .state = true;
                                    if (!context.mounted) return;
                                    context.pop();
                                    context.push('/timerZapper$relojNumber');
                                }
                              } else {
                                print(
                                    '<<<<<<<<<<<<<< DeviveProvider desconectado >>>>>>>>>>>>>>');
                                if (!context.mounted) return;
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AvisoErrorConexion(
                                          title: 'Revise la conexión bluetooth',
                                          content:
                                              'El equipo ${ref.read(deviceProvider).nombre} esta desconectado');
                                    });
                                await Future.delayed(
                                    const Duration(seconds: 5));
                                ref
                                    .read(isEnabledButtonPlayProvider.notifier)
                                    .state = true;
                                if (!context.mounted) return;
                                context.pop();
                                if (!context.mounted) return;
                                context.pop();
                              }
                            }
                          : null,
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
        ),
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
