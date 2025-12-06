import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    TextEditingController nombreDeviceController = TextEditingController();

    final String location = '/bluetooth';
    ScrollController scroll = ScrollController();

    Map<String, dynamic> orden = {
      'command': 'conectar',
      'deviceId': '94:A9:A8:39:16:59'
    };

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          print('***************** didPop es true $didPop *************');
          //return;
        } else {
          print('***************** didPop es false $didPop *************');
          //context.go('/');
          //context.pop();
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
                              image: userImage(),
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
                                      color: Color.fromARGB(255, 50, 102, 175),
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
                                                .scanDevices(3);
                                          } else {
                                            await ref
                                                .read(bleProvider)
                                                .bleTurnOn();
                                            print(
                                                '>>>>>>>>>>>>>>>>>> Llamando scanDevice(5) despues de enceder el bluetooth con bleTurnOn()porque estaba apagado');
                                            await ref
                                                .read(bleProvider)
                                                .scanDevices(3);
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
                                stream:
                                    ref.read(bleProvider).streamScannedDevices,
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
                                                          Colors.transparent)),
                                              onPressed: () async {
                                                final List<Device>
                                                    listDeviceEmpty = [];
                                                ref
                                                    .read(bleProvider)
                                                    .setScannedDevices(
                                                        listDeviceEmpty);
                                                ref
                                                    .read(isScanEnabledProvider
                                                        .notifier)
                                                    .update((state) => false);
                                                /* BluetoothDevice
                                                    bluetoothDevice =
                                                    BluetoothDevice.fromId(
                                                        data.mac); */
                                                if (!await ref
                                                    .read(servicesProvider)
                                                    .getDeviceExists(
                                                        data.mac)) {
                                                  if (!context.mounted) return;
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            children: [
                                                              const Text(
                                                                  'Asigne un nombre al equipo'),
                                                              Form(
                                                                key: formKey,
                                                                child:
                                                                    TextFormField(
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  textCapitalization:
                                                                      TextCapitalization
                                                                          .characters,
                                                                  maxLength: 10,
                                                                  cursorColor:
                                                                      Colors
                                                                          .blue,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                                  controller:
                                                                      nombreDeviceController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  /* decoration: formDecorationTerapia(
                                                                                                        'Nombre', '', null), */
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Requerido';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  /* ref
                                                                    .watch(
                                                                        origenHomeZapperProvider
                                                                            .notifier)
                                                                    .state = true; */
                                                                  context.pop();
                                                                },
                                                                child: const Text(
                                                                    'Volver')),
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    await ref.read(servicesProvider).addDevice(Device(
                                                                        tipo: data
                                                                            .tipo,
                                                                        mac: data
                                                                            .mac,
                                                                        nombre: nombreDeviceController
                                                                            .text
                                                                            .toUpperCase(),
                                                                        conectado:
                                                                            true,
                                                                        relojAsignado:
                                                                            0));
                                                                    ref.read(deviceProvider.notifier).update((state) => Device(
                                                                        tipo: data
                                                                            .tipo,
                                                                        mac: data
                                                                            .mac,
                                                                        nombre: nombreDeviceController
                                                                            .text
                                                                            .toUpperCase(),
                                                                        conectado:
                                                                            true,
                                                                        relojAsignado:
                                                                            0));
                                                                    await ref
                                                                        .read(
                                                                            bleProvider)
                                                                        .conectar(
                                                                            data.mac);
                                                                    context
                                                                        .pop();
                                                                  }
                                                                },
                                                                child: const Text(
                                                                    'Conectar'))
                                                          ],
                                                        );
                                                      });
                                                } else {
                                                  final Device dev = await ref
                                                      .read(servicesProvider)
                                                      .getDevice(data.mac);
                                                  dev.conectado = true;
                                                  await ref
                                                      .read(servicesProvider)
                                                      .editDevice(dev);
                                                  ref
                                                      .read(deviceProvider
                                                          .notifier)
                                                      .update((state) => dev);
                                                  await ref
                                                      .read(bleProvider)
                                                      .conectar(data.mac);
                                                }
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(data.tipo,
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              50,
                                                              102,
                                                              175),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(data.nombre,
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              50,
                                                              102,
                                                              175),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
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
                                    /* subscriptionStateConection?.cancel();
                                    subscriptionStateConection = ref
                                        .read(bleProvider)
                                        .conectionState
                                        .listen((event) async {
                                      subscriptionStateConection?.cancel();
                                      final Device dev = await ref
                                          .read(servicesProvider)
                                          .getDevice(
                                              event.device.remoteId.toString());
                                      if (event.connectionState ==
                                          BluetoothConnectionState
                                              .disconnected) {
                                        await ref
                                            .read(bleProvider)
                                            .caracteristicas(
                                                event.device, true);
                                        dev.conectado = false;
                                        await ref
                                            .read(servicesProvider)
                                            .editDevice(dev);
                                        print(
                                            '<<<<<<<<<<<<<<<EL DISPOSITIVO: ${event.device}');
                                        if (!event
                                                .device.isAutoConnectEnabled &&
                                            ref.read(reConectarProvider)) {
                                          await ref
                                              .read(bleProvider)
                                              .reConectar(event.device);
                                        }
                                        //ref.invalidate(servicesProvider);
                                      }
                                      if (event.connectionState ==
                                          BluetoothConnectionState.connected) {
                                        /* if (ref
                                          .watch(countdownProvider)
                                          .backUpComando
                                          .isNotEmpty) {
                                        print(
                                            '<<<<<<<<<< REENVIAR COMANDO >>>>>>>>>>');
                                      } */
                                        print(
                                            '***********>>>>> estoy en event.connected');
                                        ref
                                            .read(reConectarProvider.notifier)
                                            .update((state) => true);
                                        dev.conectado = true;

                                        await ref
                                            .read(servicesProvider)
                                            .editDevice(dev);
                                        if (event.device.isAutoConnectEnabled) {
                                          bool characteristicExist = false;
                                          for (int i = 0; i < 5; i++) {
                                            if (ref
                                                    .read(bleProvider)
                                                    .getListCaracteristicas[i]
                                                    .remoteId ==
                                                event.device.remoteId) {
                                              characteristicExist = true;
                                              i = 5;
                                            }
                                          }
                                          if (!characteristicExist &&
                                              dev.relojAsignado == 0) {
                                            await ref
                                                .read(bleProvider)
                                                .descubrirServicios(
                                                    event.device);
                                          }
                                        }

                                        //ref.invalidate(servicesProvider);
                                      }
                                      ref.invalidate(servicesProvider);
                                    }); */

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
                                                          Colors.transparent)),
                                              onPressed: () async {
                                                //await subscriptionStateConection?.cancel();
                                                ref
                                                    .read(
                                                        deviceProvider.notifier)
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
                                                  if (data.relojAsignado > 0) {
                                                    context.push(
                                                        '/timerZapper${data.relojAsignado}');
                                                  } else {
                                                    ref
                                                        .read(countdownProvider)
                                                        .volver(false);
                                                    ref
                                                        .read(selectModoProvider
                                                            .notifier)
                                                        .state = false;
                                                    ref
                                                        .read(
                                                            indexTerapiaProvider
                                                                .notifier)
                                                        .state = 0;
                                                    context.push('/homeZapper');
                                                  }
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Consumer(builder:
                                                      (context, ref, _) {
                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            widthScreen * 0.008,
                                                        //vertical: heightScreen * 0.01
                                                      ),
                                                      height:
                                                          heightScreen * 0.06,
                                                      width: widthScreen * 0.04,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              invertColors:
                                                                  false,
                                                              fit: BoxFit.fill,
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
                                                          minimumSize: MaterialStatePropertyAll(
                                                              Size(
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
                                                            color: Colors.white,
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
                bottomNavigationBar:
                    const SafeArea(child: NavigationBarRedes())),
          ],
        ),
      ),
    );
  }
}
