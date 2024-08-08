import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/agregar_terapia.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/editar_terapia.dart';
import 'package:flutter_application_1/eliminar_terapia.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeZapperScreen extends ConsumerWidget {
  const HomeZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(countdownProvider);
    final bool modoSeleccionado = ref.watch(selectModoProvider);
    //final int terapiaSeleccionada = ref.watch(indexTerapiaProvider);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
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
        TextEditingController(text: ref.watch(terapiaProvider).nombre);
    final frecMinimaEditarTerapiaController = TextEditingController(
        text: ref.watch(terapiaProvider).frecMin.toString());
    final frecMaximaEditarTerapiaController = TextEditingController(
        text: ref.watch(terapiaProvider).frecMax.toString());
    final descripcionEditarTerapiaController =
        TextEditingController(text: ref.watch(terapiaProvider).info);

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
                        'ZAPPER ${ref.watch(indexTerapiaProvider)}',
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(user!.photoURL!)),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              centerTitle: true,
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
                              onPressed: !ref.watch(terapiaProvider).editable
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
                              onPressed: !ref.watch(terapiaProvider).editable
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
              alignment: Alignment.bottomCenter,
              height: 60,
              width: 80,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(97, 62, 161, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              //padding: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.bottomCenter,
                constraints: BoxConstraints(maxHeight: 56, maxWidth: 56),
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
                    ref.read(terapiaProvider.notifier).state = await ref
                        .watch(servicesProvider)
                        .getTerapiaSeleccionada(puntero);
                    modoSeleccionado
                        ? timer.startStopTimer('Modo A')
                        : timer.startStopTimer('Modo B');
                    context.push('/timerZapper');
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
              ref.read(terapiaProvider.notifier).state = await ref
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
