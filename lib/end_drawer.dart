import 'package:flutter/material.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EndDrawer extends ConsumerWidget {
  const EndDrawer({
    super.key,
    required this.widthScreen,
    required this.heightScreen,
  });

  final double widthScreen;
  final double heightScreen;

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
                    Container(
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
                                          context.push(
                                              '/timerZapper${data.relojAsignado}');
                                        },
                                        child: Text(data.nombre));
                                  });
                            } else {
                              return const Center(
                                  child: Text('No devices found'));
                            }
                          }),
                    ),
                    TextButton(
                        onPressed: () {},
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
}
