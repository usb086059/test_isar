import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/countdown_provider_2.dart';
import 'package:flutter_application_1/countdown_provider_3.dart';
import 'package:flutter_application_1/countdown_provider_4.dart';
import 'package:flutter_application_1/countdown_provider_5.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EndDrawer extends ConsumerWidget {
  const EndDrawer(
      {super.key,
      required this.widthScreen,
      required this.heightScreen,
      required this.location});

  final double widthScreen;
  final double heightScreen;
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* List<String> listaRelojesOcupados = ref
        .watch(relojProvider)
        .where((element) => element != 'disponible')
        .toList(); */
    return Drawer(
      width: widthScreen * 0.3,
      backgroundColor: Colors.transparent,
      child: Container(
        height: heightScreen,
        //color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: heightScreen * 0.111,
              //color: Colors.transparent,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              child: Container(
                height: heightScreen * 0.41,
                //color: Colors.white,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    /* Container(
                        width: widthScreen * 0.3,
                        color: Colors.green,
                        child: const Text(
                          'RELOJES',
                          textAlign: TextAlign.center,
                        )),
                    Container(
                      //padding: EdgeInsets.all(0),
                      //margin: EdgeInsets.all(0),
                      //alignment: Alignment.topCenter,
                      height: heightScreen * 0.31,
                      color: Colors.green,
                      child: FutureBuilder<List<Device>>(
                          future: ref
                              .watch(servicesProvider)
                              .getAllDeviceConRelojAsignado(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              ref.invalidate(servicesProvider);
                              return ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data![index];
                                    return TextButton(
                                        style: const ButtonStyle(),
                                        onPressed: () {
                                          ref
                                              .read(deviceProvider.notifier)
                                              .update((state) => state = data);
                                          if ('/timerZapper${data.relojAsignado}' !=
                                              location) {
                                            context.replace(
                                                '/timerZapper${data.relojAsignado}');
                                          }
                                        },
                                        child: Text(data.nombre));
                                  });
                            } else {
                              return const Center(
                                  child: Text('No devices found'));
                            }
                          }),
                    ), */
                    TextButton(
                        onPressed: () async {
                          final List<Device> listDeviceWithRelojAsignado =
                              await ref
                                  .read(servicesProvider)
                                  .getAllDeviceConRelojAsignado();
                          if (listDeviceWithRelojAsignado.isNotEmpty) {
                            print(
                                '*************** ${listDeviceWithRelojAsignado.length}');
                            for (Device element
                                in listDeviceWithRelojAsignado) {
                              switch (element.relojAsignado) {
                                case 1:
                                  ref.read(countdownProvider).cancelarTimer();
                                  await cerrar(ref, element);
                                  break;
                                case 2:
                                  ref.read(countdownProvider2).cancelarTimer();
                                  await cerrar(ref, element);
                                  break;
                                case 3:
                                  ref.read(countdownProvider3).cancelarTimer();
                                  await cerrar(ref, element);
                                  break;
                                case 4:
                                  ref.read(countdownProvider4).cancelarTimer();
                                  await cerrar(ref, element);
                                  break;
                                case 5:
                                  ref.read(countdownProvider5).cancelarTimer();
                                  await cerrar(ref, element);
                                  break;
                                default:
                                  break;
                              }
                            }
                          }
                          await Future.delayed(const Duration(seconds: 2));
                          final List<Device> listDevicesConnected = await ref
                              .read(servicesProvider)
                              .getAllDeviceConected();
                          if (listDevicesConnected.isNotEmpty) {
                            for (Device element in listDevicesConnected) {
                              element.conectado = false;
                              await ref
                                  .read(servicesProvider)
                                  .editDevice(element);
                              ref
                                  .read(reConectarProvider.notifier)
                                  .update((state) => false);
                              await ref
                                  .read(bleProvider)
                                  .desconectar2(element.mac);
                              await Future.delayed(const Duration(seconds: 1));
                            }
                          }
                          ref.invalidate(servicesProvider);
                          await Future.delayed(const Duration(seconds: 1));
                          await signOutWithGoogle();
                          ref
                              .read(cerroSesion.notifier)
                              .update((state) => true);
                          if (context.mounted) {
                            context.push('/');
                            //context.pop();
                            //context.pushReplacement('/');
                          }
                        },
                        child: const Text(
                          'Cerrar Sesión',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cerrar(WidgetRef ref, Device device) async {
    ref.read(relojProvider.notifier).state[device.relojAsignado] = 'disponible';
    device.relojAsignado = 0;
    await ref.read(servicesProvider).editDevice(device);
  }
}
