import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/services.dart';
//import 'package:isar/isar.dart';

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    final String nameUser = user!.displayName!;

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
                        nameUser,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(user.photoURL!)),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              centerTitle: false,
            ),
            body: Container(
              height: heightScreen,
              width: widthScreen,
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/dedo_touch.png',
                        scale: 4,
                        color: const Color.fromARGB(255, 50, 102, 175),
                      ),
                      //const SizedBox(height: 10),
                      const FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.scaleDown,
                        child: Text('ELIJA EL DISPOSITIVO',
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 50, 102, 175),
                                fontWeight: FontWeight.bold)),
                      ),
                      //const SizedBox(height: 16),
                      CustomIconSelectDevice(
                        deviceName: 'PEDILUVIO',
                        addresImageDevice: 'assets/icons/icon_circulo.png',
                        contextDevicesScreen: context,
                        refDevicesScreen: ref,
                      ),
                      CustomIconSelectDevice(
                        deviceName: 'PEDILUVIO CON ZAPPER',
                        addresImageDevice: 'assets/icons/icon_circulo.png',
                        contextDevicesScreen: context,
                        refDevicesScreen: ref,
                      ),
                      CustomIconSelectDevice(
                        deviceName: 'ZAPPER',
                        addresImageDevice: 'assets/icons/icon_circulo.png',
                        contextDevicesScreen: context,
                        refDevicesScreen: ref,
                      ),
                      CustomIconSelectDevice(
                        deviceName: 'DERMATRONIC',
                        addresImageDevice: 'assets/icons/icon_circulo.png',
                        contextDevicesScreen: context,
                        refDevicesScreen: ref,
                      ),
                      //const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconSelectDevice extends ConsumerWidget {
  final BuildContext contextDevicesScreen;
  final WidgetRef refDevicesScreen;
  final String deviceName;
  final String addresImageDevice;

  const CustomIconSelectDevice({
    super.key,
    required this.deviceName,
    required this.addresImageDevice,
    required this.contextDevicesScreen,
    required this.refDevicesScreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/icons/icono9.png'))),
      child: Card(
        margin: const EdgeInsets.only(top: 11, bottom: 29, left: 16, right: 16),
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: ListTile(
          onTap: onTapSelectDevice(contextDevicesScreen, refDevicesScreen),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(addresImageDevice, scale: 52),
              const SizedBox(width: 16),
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(deviceName,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 50, 102, 175),
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureTapCallback onTapSelectDevice(BuildContext context, WidgetRef ref) {
    if (deviceName == 'PEDILUVIO') {
      return () {};
    } else if (deviceName == 'PEDILUVIO CON ZAPPER') {
      return () {};
    } else if (deviceName == 'ZAPPER') {
      return () async {
        await ref
            .watch(servicesProvider)
            .terapiasIniciales(); //Actualiza terapias iniciales si es necesario
        await ref
            .watch(servicesProvider)
            .cargarTerapiaTotal(); //Carga las terapias que se mostraran en el Gridview (terapias iniciales + personales)
        ref.read(origenHomeZapperProvider.notifier).state = true;
        ref.read(selectModoProvider.notifier).state = false;
        ref.read(indexTerapiaProvider.notifier).state = 0;
        ref.read(terapiaProvider.notifier).state =
            await ref.watch(servicesProvider).getTerapiaSeleccionada(0);
        context.push('/homeZapper');
      };
    } else if (deviceName == 'DERMATRONIC') {
      return () {};
    } else {
      return () {};
    }
  }
}
