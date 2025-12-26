import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth_provider.dart';
//import 'package:flutter_application_1/battery_levels.dart';
import 'package:flutter_application_1/ble_services.dart';
//import 'package:flutter_application_1/caracteristicas.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/end_drawer.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/navigation_bar_redes.dart';
//import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/set_name_my_device.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/state_provider.dart';
//import 'package:isar/isar.dart';

class BleScreen extends ConsumerWidget {
  const BleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(
        '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< **** Construyendo bleScreen **** >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    //final bluetoothProvider = ref.watch(bleProvider);
    /* StreamSubscription<OnConnectionStateChangedEvent>?
        subscriptionStateConection; */
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    //List<BluetoothDevice> listaDC = [];
    final formKey = GlobalKey<FormState>();

    final String location = '/bluetooth';
    ScrollController scroll = ScrollController();

    Map<String, dynamic> orden = {
      'command': 'conectar',
      'deviceId': '94:A9:A8:39:16:59'
    };

    final isEnableButtonSelectDeviceScanned =
        ref.watch(isEnableButtonSelectDeviceScannedProvider);

    final imagePath = ref.watch(userImageProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          print('***************** didPop es true $didPop *************');
          //return;
        } else {
          print('***************** didPop es false $didPop *************');
          //context.go('/');
          //context.pop();
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
                  endDrawer: EndDrawer(
                    widthScreen: widthScreen,
                    heightScreen: heightScreen,
                    location: location,
                  ),
                  endDrawerEnableOpenDragGesture: false,
                  appBar: AppBar(
                    /* leading: IconButton(
                        onPressed: () async {
                          FlutterForegroundTask.sendDataToTask(orden);
                          print(
                              '*************** UI: Enviando comando de conexión a TaskHandler');
                        },
                        icon: const Icon(Icons.ac_unit)), */
                    flexibleSpace: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Stack(
                        //TODO: quitar el Stack porque quedó un solo hijo
                        children: [
                          Center(
                            child: Text(
                              'EQUIPOS',
                              style: TextStyle(
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
                                image:
                                    AssetImage('assets/icons/icon_circulo.png'),
                              )),
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
                      /* SizedBox(
                      height: heightScreen * 0.06,
                      width: widthScreen * 0.056,
                    ), */
                      Builder(builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(0),
                          margin: EdgeInsets.symmetric(
                            horizontal: widthScreen * 0.008,
                            //vertical: heightScreen * 0.01
                          ),
                          height: heightScreen * 0.06,
                          width: widthScreen * 0.04,
                          /* decoration: const BoxDecoration(
                              image: DecorationImage(
                                  invertColors: true,
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/icons/letra-x.png'))), */
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                //highlightColor: Colors.black,
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                                icon: const Icon(
                                  //Icons.cancel_presentation,
                                  //Icons.more_vert,
                                  Icons.menu,
                                  size: 60,
                                  color: Colors.white,
                                  //color: Colors.transparent,
                                )),
                          ),
                        );
                      })
                    ],
                  ),
                  body: Container(
                    height: heightScreen,
                    width: widthScreen,
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 16, left: 16, right: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('BUSCAR DISPOSITIVOS',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 50, 102, 175),
                                        fontWeight: FontWeight.bold)),
                                IconButton.filled(
                                    onPressed: ref.watch(isScanEnabledProvider)
                                        ? () async {
                                            final List<Device> listDeviceEmpty =
                                                [];
                                            ref
                                                .read(bleProvider)
                                                .setScannedDevices(
                                                    listDeviceEmpty);
                                            ref
                                                .read(isScanEnabledProvider
                                                    .notifier)
                                                .update((state) => false);
                                            //await bluetoothProvider.bleState();
                                            if (await ref
                                                .read(bleProvider)
                                                .bleState()) {
                                              print(
                                                  '>>>>>>>>>>>>>>>>>> Llamando scanDevice(5) porque el bluetooth si esta encendido');
                                              await ref
                                                  .read(bleProvider)
                                                  .scanDevices(2);
                                            } else {
                                              await ref
                                                  .read(bleProvider)
                                                  .bleTurnOn();
                                              print(
                                                  '>>>>>>>>>>>>>>>>>> Llamando scanDevice(5) despues de enceder el bluetooth con bleTurnOn()porque estaba apagado');
                                              await ref
                                                  .read(bleProvider)
                                                  .scanDevices(2);
                                            }
                                          }
                                        : null,
                                    icon: const Icon(Icons.search))
                              ],
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxHeight: heightScreen * 0.2,
                                  maxWidth: widthScreen * 0.95),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: StreamBuilder<List<Device>>(
                                  stream: ref
                                      .read(bleProvider)
                                      .streamScannedDevices,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.isEmpty &&
                                          !ref.read(isScanEnabledProvider)) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final data = snapshot.data![index];
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 26,
                                                  left: 16,
                                                  right: 16),
                                              decoration: const BoxDecoration(
                                                  //borderRadius: BorderRadius.circular(45),
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          'assets/icons/icono9.png'))),
                                              child: FilledButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors
                                                                .transparent)),
                                                onPressed:
                                                    isEnableButtonSelectDeviceScanned
                                                        ? () async {
                                                            ref
                                                                .read(isEnableButtonSelectDeviceScannedProvider
                                                                    .notifier)
                                                                .state = false;
                                                            final List<Device>
                                                                listDeviceEmpty =
                                                                [];
                                                            ref
                                                                .read(
                                                                    bleProvider)
                                                                .setScannedDevices(
                                                                    listDeviceEmpty);
                                                            /* ref
                                                      .read(isScanEnabledProvider
                                                          .notifier)
                                                      .update((state) => false); */
                                                            /* BluetoothDevice
                                                      bluetoothDevice =
                                                      BluetoothDevice.fromId(
                                                          data.mac); */
                                                            if (!await ref
                                                                .read(
                                                                    servicesProvider)
                                                                .getDeviceExists(
                                                                    data.mac)) {
                                                              ref
                                                                  .read(isEnabledButtonConectarProvider
                                                                      .notifier)
                                                                  .state = true;
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          SetNameMyDevice(
                                                                            data:
                                                                                data,
                                                                            formKey:
                                                                                formKey,
                                                                            editEnable:
                                                                                false,
                                                                          ));
                                                            } else {
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          50,
                                                                          102,
                                                                          175),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .purple[300],
                                                                    ));
                                                                  });
                                                              final Device dev =
                                                                  await ref
                                                                      .read(
                                                                          servicesProvider)
                                                                      .getDevice(
                                                                          data.mac);
                                                              dev.conectado =
                                                                  true;
                                                              await ref
                                                                  .read(
                                                                      servicesProvider)
                                                                  .editDevice(
                                                                      dev);
                                                              ref
                                                                  .read(deviceProvider
                                                                      .notifier)
                                                                  .update(
                                                                      (state) =>
                                                                          dev);
                                                              await ref
                                                                  .read(
                                                                      bleProvider)
                                                                  .conectar(
                                                                      data.mac);
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              context.pop();
                                                            }
                                                            ref
                                                                .read(isEnableButtonSelectDeviceScannedProvider
                                                                    .notifier)
                                                                .state = true;
                                                          }
                                                        : null,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(data.tipo,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          102,
                                                                          175),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(data.nombre,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          102,
                                                                          175),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: data.nombre !=
                                                          'Sin nombre',
                                                      child: TextButton(
                                                          style: ButtonStyle(
                                                              minimumSize: WidgetStatePropertyAll(Size(
                                                                  widthScreen *
                                                                      0.15,
                                                                  heightScreen *
                                                                      0.034)),
                                                              maximumSize: WidgetStatePropertyAll(Size(
                                                                  widthScreen *
                                                                      0.15,
                                                                  heightScreen *
                                                                      0.034)),
                                                              /* alignment: Alignment
                                                                  .centerRight, */
                                                              padding:
                                                                  const WidgetStatePropertyAll(
                                                                      EdgeInsets
                                                                          .zero),
                                                              backgroundColor: data
                                                                          .nombre ==
                                                                      'Sin nombre'
                                                                  ? const WidgetStatePropertyAll(
                                                                      Colors
                                                                          .black12)
                                                                  : const WidgetStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          50,
                                                                          102,
                                                                          175))),
                                                          onPressed: data
                                                                      .nombre ==
                                                                  'Sin nombre'
                                                              ? null
                                                              : () {
                                                                  ref
                                                                      .read(isEnableButtonSelectDeviceScannedProvider
                                                                          .notifier)
                                                                      .state = false;
                                                                  ref
                                                                      .read(isEnabledButtonConectarProvider
                                                                          .notifier)
                                                                      .state = true;
                                                                  showDialog(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              SetNameMyDevice(
                                                                                data: data,
                                                                                formKey: formKey,
                                                                                editEnable: true,
                                                                              ));
                                                                  ref
                                                                      .read(isEnableButtonSelectDeviceScannedProvider
                                                                          .notifier)
                                                                      .state = true;
                                                                },
                                                          child: const Text(
                                                            'Editar',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }),
                            ),
                            Divider(height: 10, color: Colors.blue[50]),
                            Divider(height: 10, color: Colors.blue[50]),
                            Divider(height: 10, color: Colors.blue[50]),
                            const Text(
                              'DISPOSITIVOS CONECTADOS',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 50, 102, 175),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxHeight: heightScreen * 0.6,
                                  maxWidth: widthScreen * 0.95),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: FutureBuilder<List<Device>>(
                                  future: ref
                                      .watch(servicesProvider)
                                      .getAllDeviceConected(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      print(
                                          '******************* FUERA DEL LISTEN ********');
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final data = snapshot.data![index];
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 26,
                                                  left: 16,
                                                  right: 16),
                                              decoration: const BoxDecoration(
                                                  //borderRadius: BorderRadius.circular(45),
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          'assets/icons/icono9.png'))),
                                              child: FilledButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors
                                                                .transparent)),
                                                onPressed: () async {
                                                  //await subscriptionStateConection?.cancel();
                                                  ref
                                                      .read(deviceProvider
                                                          .notifier)
                                                      .update((state) => data);
                                                  /* ref
                                                          .read(terapiaProvider1
                                                              .notifier)
                                                          .state =
                                                      await ref
                                                          .read(servicesProvider)
                                                          .getTerapiaSeleccionada(
                                                              0); */
                                                  if (context.mounted) {
                                                    print(
                                                        '***************** Reloj Asignado: ${data.relojAsignado}');
                                                    if (data.relojAsignado >
                                                        0) {
                                                      context.push(
                                                          '/timerZapper${data.relojAsignado}');
                                                    } else {
                                                      ref
                                                          .read(
                                                              isComingFromSomeTimerScreen
                                                                  .notifier)
                                                          .state = false;
                                                      ref
                                                          .read(
                                                              selectModoProvider
                                                                  .notifier)
                                                          .state = false;
                                                      ref
                                                          .read(
                                                              indexTerapiaProvider
                                                                  .notifier)
                                                          .state = 0;
                                                      context
                                                          .push('/homeZapper');
                                                    }
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Consumer(builder:
                                                        (context, ref, _) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              widthScreen *
                                                                  0.008,
                                                          //vertical: heightScreen * 0.01
                                                        ),
                                                        height:
                                                            heightScreen * 0.06,
                                                        width:
                                                            widthScreen * 0.04,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                invertColors:
                                                                    false,
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: AssetImage(ref
                                                                    .watch(
                                                                        bleProvider)
                                                                    .getBatteryLevelAzul(
                                                                        data.mac)))),
                                                      );
                                                    }),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            data.nombre,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        50,
                                                                        102,
                                                                        175),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              'Equipo: ${data.tipo}',
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          102,
                                                                          175),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                        ],
                                                      ),
                                                    ),
                                                    TextButton(
                                                        style: ButtonStyle(
                                                            minimumSize:
                                                                MaterialStatePropertyAll(Size(
                                                                    widthScreen *
                                                                        0.15,
                                                                    heightScreen *
                                                                        0.034)),
                                                            maximumSize:
                                                                MaterialStatePropertyAll(Size(
                                                                    widthScreen *
                                                                        0.15,
                                                                    heightScreen *
                                                                        0.034)),
                                                            /* alignment: Alignment
                                                                .centerRight, */
                                                            padding:
                                                                const MaterialStatePropertyAll(
                                                                    EdgeInsets
                                                                        .zero),
                                                            backgroundColor:
                                                                const MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        50,
                                                                        102,
                                                                        175))),
                                                        onPressed: ref.watch(
                                                                isApagarEnabledProvider)
                                                            ? () async {
                                                                ref
                                                                    .read(isApagarEnabledProvider
                                                                        .notifier)
                                                                    .update(
                                                                        (state) =>
                                                                            false);
                                                                if (data.relojAsignado >
                                                                    0) {
                                                                  ref.read(relojProvider.notifier).state[
                                                                          data.relojAsignado] =
                                                                      'disponible';
                                                                  data.relojAsignado =
                                                                      0;
                                                                }
                                                                data.conectado =
                                                                    false;
                                                                await ref
                                                                    .read(
                                                                        servicesProvider)
                                                                    .editDevice(
                                                                        data);
                                                                ref
                                                                    .read(reConectarProvider
                                                                        .notifier)
                                                                    .update(
                                                                        (state) =>
                                                                            false);
                                                                await ref
                                                                    .read(
                                                                        bleProvider)
                                                                    .desconectar2(
                                                                        data.mac);
                                                                ref
                                                                    .read(isApagarEnabledProvider
                                                                        .notifier)
                                                                    .update(
                                                                        (state) =>
                                                                            true);
                                                              }
                                                            : null,
                                                        child: const Text(
                                                          'Apagar',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        )),
                                                    /* Column(
                                                      children: [
                                                        IconButton(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                EdgeInsets.all(0),
                                                            onPressed: () {},
                                                            icon: Icon(Icons
                                                                .power_settings_new)),
                                                        Text('Apagar')
                                                      ],
                                                    ) */
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: const NavigationBarRedes()),
            ],
          ),
        ),
      ),
    );
  }
}
