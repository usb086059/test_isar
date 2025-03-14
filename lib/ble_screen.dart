import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/end_drawer.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:isar/isar.dart';

class BleScreen extends ConsumerWidget {
  const BleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StreamSubscription<OnConnectionStateChangedEvent>?
        subscriptionStateConection;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    final bluetoothProvider = ref.watch(bleProvider);
    List<BluetoothDevice> listaDC = [];
    final formKey = GlobalKey<FormState>();
    TextEditingController nombreDeviceController = TextEditingController();

    final String location = '/bluetooth';

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
                  Builder(builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      height: heightScreen * 0.1,
                      width: widthScreen * 0.15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(user!.photoURL!))),
                      child: Center(
                          child: IconButton(
                              //highlightColor: Colors.black,
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.transparent,
                              ))),
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
                        top: 8, bottom: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        /* const Text('ESCANEAR DISPOSITIVOS',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 50, 102, 175),
                                fontWeight: FontWeight.bold)), */
                        ElevatedButton(
                            onPressed: () async {
                              //await bluetoothProvider.bleState();
                              if (await bluetoothProvider.bleState()) {
                                await bluetoothProvider.scanDevices(5);
                              } else {
                                await bluetoothProvider.bleTurnOn();
                                await bluetoothProvider.scanDevices(5);
                              }
                            },
                            child: const Text('Escanear Dispositivos')),
                        Container(
                          constraints: BoxConstraints(
                              maxHeight: heightScreen * 0.2,
                              maxWidth: widthScreen * 0.95),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: StreamBuilder<List<ScanResult>>(
                              stream: bluetoothProvider.scanResults,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final data = snapshot.data![index];
                                        return Card(
                                          child: ListTile(
                                            onTap: () async {
                                              if (!await ref
                                                  .watch(servicesProvider)
                                                  .getDeviceExists(data
                                                      .device.remoteId
                                                      .toString())) {
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
                                                                    Colors.blue,
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
                                                                  await ref.watch(servicesProvider).addDevice(Device(
                                                                      tipo: data
                                                                          .device
                                                                          .advName,
                                                                      mac: data
                                                                          .device
                                                                          .remoteId
                                                                          .toString(),
                                                                      nombre: nombreDeviceController
                                                                          .text
                                                                          .toUpperCase(),
                                                                      conectado:
                                                                          true,
                                                                      relojAsignado:
                                                                          0));
                                                                  ref.read(deviceProvider.notifier).update((state) => Device(
                                                                      tipo: data
                                                                          .device
                                                                          .advName,
                                                                      mac: data
                                                                          .device
                                                                          .remoteId
                                                                          .toString(),
                                                                      nombre: nombreDeviceController
                                                                          .text
                                                                          .toUpperCase(),
                                                                      conectado:
                                                                          true,
                                                                      relojAsignado:
                                                                          0));
                                                                  await bluetoothProvider
                                                                      .conectar(
                                                                          data.device);
                                                                  context.pop();
                                                                }
                                                              },
                                                              child: const Text(
                                                                  'Conectar'))
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                final Device dev = await ref
                                                    .watch(servicesProvider)
                                                    .getDevice(data
                                                        .device.remoteId
                                                        .toString());
                                                dev.conectado = true;
                                                await ref
                                                    .watch(servicesProvider)
                                                    .editDevice(dev);
                                                ref
                                                    .read(
                                                        deviceProvider.notifier)
                                                    .update((state) => dev);
                                                await bluetoothProvider
                                                    .conectar(data.device);
                                              }
                                            },
                                            title: Text(data.device.advName),
                                            subtitle: Text(data.device.remoteId
                                                .toString()),
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                      child: Text('No devices found'));
                                }
                              }),
                        ),
                        const Divider(height: 10, color: Colors.blue),
                        ElevatedButton(
                            onPressed: () async {},
                            child: const Text('Dispositivos Conectados')),
                        Container(
                          constraints: BoxConstraints(
                              maxHeight: heightScreen * 0.6,
                              maxWidth: widthScreen * 0.95),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                                  subscriptionStateConection?.cancel();
                                  subscriptionStateConection = bluetoothProvider
                                      .conectionState
                                      .listen((event) async {
                                    final Device dev = await ref
                                        .watch(servicesProvider)
                                        .getDevice(
                                            event.device.remoteId.toString());
                                    if (event.connectionState ==
                                        BluetoothConnectionState.disconnected) {
                                      dev.conectado = false;
                                      await ref
                                          .watch(servicesProvider)
                                          .editDevice(dev);
                                      print(
                                          '<<<<<<<<<<<<<<<EL DISPOSITIVO: ${event.device}');
                                      if (!event.device.isAutoConnectEnabled &&
                                          ref.watch(reConectarProvider)) {
                                        await bluetoothProvider
                                            .reConectar(event.device);
                                      }
                                      ref.invalidate(servicesProvider);
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
                                      ref
                                          .read(reConectarProvider.notifier)
                                          .update((state) => true);
                                      dev.conectado = true;

                                      await ref
                                          .watch(servicesProvider)
                                          .editDevice(dev);

                                      ref.invalidate(servicesProvider);
                                    }
                                  });

                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final data = snapshot.data![index];
                                        return Card(
                                          child: ListTile(
                                            onTap: () async {
                                              await subscriptionStateConection
                                                  ?.cancel();
                                              ref
                                                  .read(deviceProvider.notifier)
                                                  .update((state) => data);
                                              ref
                                                  .watch(countdownProvider)
                                                  .volver(false);
                                              ref
                                                  .read(selectModoProvider
                                                      .notifier)
                                                  .state = false;
                                              ref
                                                  .read(indexTerapiaProvider
                                                      .notifier)
                                                  .state = 0;
                                              ref
                                                      .read(terapiaProvider1
                                                          .notifier)
                                                      .state =
                                                  await ref
                                                      .watch(servicesProvider)
                                                      .getTerapiaSeleccionada(
                                                          0);
                                              if (context.mounted) {
                                                context.push('/homeZapper');
                                              }
                                            },
                                            title: Text(data.nombre),
                                            subtitle:
                                                Text('Equipo: ${data.tipo}'),
                                            trailing: TextButton(
                                                onPressed: () async {
                                                  if (data.relojAsignado > 0) {
                                                    ref
                                                                .read(relojProvider
                                                                    .notifier)
                                                                .state[
                                                            data.relojAsignado] =
                                                        'disponible';
                                                    data.relojAsignado = 0;
                                                  }
                                                  data.conectado = false;
                                                  await ref
                                                      .watch(servicesProvider)
                                                      .editDevice(data);
                                                  ref
                                                      .read(reConectarProvider
                                                          .notifier)
                                                      .update((state) => false);
                                                  await bluetoothProvider
                                                      .desconectar2(data.mac);
                                                },
                                                child:
                                                    const Text('Desconectar')),
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
            ),
          ],
        ),
      ),
    );
  }
}
