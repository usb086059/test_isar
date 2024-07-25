import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/future_provider.dart';
import 'package:flutter_application_1/register_screen.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/terapia.dart';
import 'package:flutter_application_1/terapia_personal.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeZapperScreen extends ConsumerWidget {
  const HomeZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(countdownProvider);
    final bool modoSeleccionado = ref.watch(selectModoProvider);
    final int terapiaSeleccionada = ref.watch(indexTerapiaProvider);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    ScrollController _scroll = ScrollController();
    final int puntero = ref.watch(indexTerapiaProvider);

    final formKey = GlobalKey<FormState>();
    final nombreTerapiaController = TextEditingController();
    final frecMinimaController = TextEditingController();
    final frecMaximaController = TextEditingController();
    final descripcionController = TextEditingController(
        text: 'Agregue una breve descripción de la terapia');
    final Terapia newTerapia;

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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Padding(
              padding: const EdgeInsets.all(4),
              child:
                  CircleAvatar(backgroundImage: NetworkImage(user!.photoURL!))),
          centerTitle: true,
          title: Text(
            'ZAPPER ${ref.watch(indexTerapiaProvider)}',
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
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
                  child: FilledButton(
                      style: ButtonStyle(
                          shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(30, 35)))),
                          backgroundColor: modoSeleccionado
                              ? const MaterialStatePropertyAll(
                                  Colors.transparent)
                              : const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 50, 102, 175))),
                      onPressed: () {
                        ref.read(selectModoProvider.notifier).state = false;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('CONTINUO',
                              style: TextStyle(
                                  color: modoSeleccionado
                                      ? const Color.fromARGB(255, 50, 102, 175)
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              '     Un ciclo único que dura 60 minutos ON     ',
                              style: TextStyle(
                                  color: modoSeleccionado
                                      ? const Color.fromARGB(255, 50, 102, 175)
                                      : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          Text('y luego finaliza la terapia.',
                              style: TextStyle(
                                  color: modoSeleccionado
                                      ? const Color.fromARGB(255, 50, 102, 175)
                                      : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      )),
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
                  child: FilledButton(
                      style: ButtonStyle(
                          shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(30, 35)))),
                          backgroundColor: modoSeleccionado
                              ? const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 50, 102, 175))
                              : const MaterialStatePropertyAll(
                                  Colors.transparent)),
                      onPressed: () {
                        ref.read(selectModoProvider.notifier).state = true;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('POR TANDAS',
                              style: TextStyle(
                                  color: modoSeleccionado
                                      ? Colors.white
                                      : const Color.fromARGB(255, 50, 102, 175),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text('Ciclo 1-2: = 7 minutos ON y 20 minutos OFF.',
                              style: TextStyle(
                                  color: modoSeleccionado
                                      ? Colors.white
                                      : const Color.fromARGB(255, 50, 102, 175),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          Text('Ciclo 3 = 7 minutos ON y termina la terapia.',
                              style: TextStyle(
                                  color: modoSeleccionado
                                      ? Colors.white
                                      : const Color.fromARGB(255, 50, 102, 175),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      )),
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
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.blue,
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          content: const Text(
                                            '¿Está seguro que quiere eliminar esta terapia?',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            TextButton(
                                                style: const ButtonStyle(
                                                    side:
                                                        MaterialStatePropertyAll(
                                                            BorderSide(
                                                  color: Colors.white,
                                                ))),
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: const Text('NO',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            TextButton(
                                                style: const ButtonStyle(
                                                    side:
                                                        MaterialStatePropertyAll(
                                                            BorderSide(
                                                  color: Colors.white,
                                                ))),
                                                onPressed: () async {
                                                  final int id = ref
                                                      .watch(terapiaProvider)
                                                      .idTerapiaPersonal;
                                                  await ref
                                                      .watch(servicesProvider)
                                                      .deleteTerapiaPersonal(
                                                          id);
                                                  await ref
                                                      .watch(servicesProvider)
                                                      .cargarTerapiaTotal();
                                                  ref
                                                          .read(terapiaProvider
                                                              .notifier)
                                                          .state =
                                                      await ref
                                                          .watch(
                                                              servicesProvider)
                                                          .getTerapiaSeleccionada(
                                                              0);

                                                  ref
                                                      .read(
                                                          origenHomeZapperProvider
                                                              .notifier)
                                                      .state = true;
                                                  ref
                                                      .read(indexTerapiaProvider
                                                          .notifier)
                                                      .state = 0;
                                                  ref
                                                      .watch(countdownProvider)
                                                      .volver(true);
                                                  context.pop();
                                                },
                                                child: const Text('SI',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ));
                              },
                        icon: const Icon(Icons.delete_forever_outlined)),
                    //SizedBox(width: 4),
                    IconButton(
                        color: const Color.fromARGB(255, 50, 102, 175),
                        disabledColor: Colors.black12,
                        onPressed: !ref.watch(terapiaProvider).editable
                            ? null
                            : () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.blue,
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          title: const Text(
                                            'Editar Terapia',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Container(
                                            constraints: BoxConstraints(
                                                maxHeight: heightScreen * 0.97,
                                                maxWidth: widthScreen * 0.95),
                                            child: SingleChildScrollView(
                                              child: Form(
                                                key: formKey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 5),
                                                    TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .characters,
                                                      maxLength: 25,
                                                      cursorColor: Colors.white,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      controller:
                                                          nombreEditarTerapiaController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          formDecorationTerapia(
                                                              'Nombre',
                                                              '',
                                                              null),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Requerido';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          width: widthScreen *
                                                              0.31,
                                                          child: TextFormField(
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                            maxLength: 3,
                                                            cursorColor:
                                                                Colors.white,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            controller:
                                                                frecMinimaEditarTerapiaController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                formDecorationTerapia(
                                                                    'Frecuencia',
                                                                    'KHz',
                                                                    'Mínima'),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Requerido';
                                                              } else {
                                                                final int?
                                                                    isInt =
                                                                    int.tryParse(
                                                                        value);
                                                                if (isInt ==
                                                                    null) {
                                                                  return 'No Letras';
                                                                } else {
                                                                  if (isInt <
                                                                      0) {
                                                                    return 'No (-)';
                                                                  }
                                                                }
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          width: widthScreen *
                                                              0.31,
                                                          child: TextFormField(
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                            maxLength: 3,
                                                            cursorColor:
                                                                Colors.white,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            controller:
                                                                frecMaximaEditarTerapiaController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                formDecorationTerapia(
                                                                    'Frecuencia',
                                                                    'KHz',
                                                                    'Máxima'),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Requerido';
                                                              } else {
                                                                final int?
                                                                    isInt =
                                                                    int.tryParse(
                                                                        value);
                                                                if (isInt ==
                                                                    null) {
                                                                  return 'No Letras';
                                                                } else {
                                                                  if (isInt <
                                                                      0) {
                                                                    return 'No (-)';
                                                                  }
                                                                }
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      maxLines: 5,
                                                      maxLength: 200,
                                                      cursorColor: Colors.white,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      controller:
                                                          descripcionEditarTerapiaController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          formDecorationTerapia(
                                                              'Descripción',
                                                              '',
                                                              null),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Requerido';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          actions: [
                                            TextButton(
                                                style: const ButtonStyle(
                                                    side:
                                                        MaterialStatePropertyAll(
                                                            BorderSide(
                                                  color: Colors.white,
                                                ))),
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: const Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            TextButton(
                                                style: const ButtonStyle(
                                                    side:
                                                        MaterialStatePropertyAll(
                                                            BorderSide(
                                                  color: Colors.white,
                                                ))),
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    TerapiaTotal
                                                        newTerapiaPersonal =
                                                        await ref.watch(
                                                            terapiaProvider);
                                                    newTerapiaPersonal.nombre =
                                                        nombreEditarTerapiaController
                                                            .text
                                                            .toUpperCase();
                                                    newTerapiaPersonal.frecMin =
                                                        int.parse(
                                                            frecMinimaEditarTerapiaController
                                                                .text);
                                                    newTerapiaPersonal.frecMax =
                                                        int.parse(
                                                            frecMaximaEditarTerapiaController
                                                                .text);
                                                    newTerapiaPersonal.info =
                                                        descripcionEditarTerapiaController
                                                            .text;
                                                    newTerapiaPersonal
                                                        .editable = true;
                                                    await ref
                                                        .watch(servicesProvider)
                                                        .editTerapiaPersonal(
                                                            newTerapiaPersonal);
                                                    await ref
                                                        .watch(servicesProvider)
                                                        .cargarTerapiaTotal();
                                                    ref
                                                            .read(
                                                                terapiaProvider
                                                                    .notifier)
                                                            .state =
                                                        await ref
                                                            .watch(
                                                                servicesProvider)
                                                            .getTerapiaSeleccionada(
                                                                0);
                                                    ref
                                                        .read(
                                                            indexTerapiaProvider
                                                                .notifier)
                                                        .state = 0;
                                                    ref
                                                        .watch(
                                                            countdownProvider)
                                                        .volver(true);
                                                    context.pop();
                                                  }
                                                },
                                                child: const Text('Guardar',
                                                    style: TextStyle(
                                                        color: Colors.white)))
                                          ],
                                        ));
                              },
                        icon: const Icon(Icons.edit_note)),
                    //SizedBox(width: 4),
                    IconButton(
                        color: const Color.fromARGB(255, 50, 102, 175),
                        disabledColor: Colors.black12,
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.blue,
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    title: const Text(
                                      'Agregar Terapia',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Container(
                                      constraints: BoxConstraints(
                                          maxHeight: heightScreen * 0.97,
                                          maxWidth: widthScreen * 0.95),
                                      child: SingleChildScrollView(
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 5),
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                maxLength: 25,
                                                cursorColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                controller:
                                                    nombreTerapiaController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration:
                                                    formDecorationTerapia(
                                                        'Nombre', '', null),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Requerido';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: widthScreen * 0.31,
                                                    child: TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      maxLength: 3,
                                                      cursorColor: Colors.white,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      controller:
                                                          frecMinimaController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          formDecorationTerapia(
                                                              'Frecuencia',
                                                              'KHz',
                                                              'Mínima'),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Requerido';
                                                        } else {
                                                          final int? isInt =
                                                              int.tryParse(
                                                                  value);
                                                          if (isInt == null) {
                                                            return 'No Letras';
                                                          } else {
                                                            if (isInt < 0) {
                                                              return 'No (-)';
                                                            }
                                                          }
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width: widthScreen * 0.31,
                                                    child: TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      maxLength: 3,
                                                      cursorColor: Colors.white,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      controller:
                                                          frecMaximaController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          formDecorationTerapia(
                                                              'Frecuencia',
                                                              'KHz',
                                                              'Máxima'),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Requerido';
                                                        } else {
                                                          final int? isInt =
                                                              int.tryParse(
                                                                  value);
                                                          if (isInt == null) {
                                                            return 'No Letras';
                                                          } else {
                                                            if (isInt < 0) {
                                                              return 'No (-)';
                                                            }
                                                          }
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                maxLines: 5,
                                                maxLength: 200,
                                                cursorColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                controller:
                                                    descripcionController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration:
                                                    formDecorationTerapia(
                                                        'Descripción',
                                                        '',
                                                        null),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Requerido';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(16),
                                    actions: [
                                      TextButton(
                                          style: const ButtonStyle(
                                              side: MaterialStatePropertyAll(
                                                  BorderSide(
                                            color: Colors.white,
                                          ))),
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: const Text(
                                            'Cancelar',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      TextButton(
                                          style: const ButtonStyle(
                                              side: MaterialStatePropertyAll(
                                                  BorderSide(
                                            color: Colors.white,
                                          ))),
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              final TerapiaPersonal
                                                  newTerapiaPersonal =
                                                  TerapiaPersonal(
                                                      nombre:
                                                          nombreTerapiaController
                                                              .text
                                                              .toUpperCase(),
                                                      frecMin: int.parse(
                                                          frecMinimaController
                                                              .text),
                                                      frecMax: int.parse(
                                                          frecMaximaController
                                                              .text),
                                                      info:
                                                          descripcionController
                                                              .text,
                                                      editable: true);
                                              await ref
                                                  .watch(servicesProvider)
                                                  .addTerapiaPersonal(
                                                      newTerapiaPersonal);
                                              await ref
                                                  .watch(servicesProvider)
                                                  .cargarTerapiaTotal();
                                              ref
                                                      .read(terapiaProvider
                                                          .notifier)
                                                      .state =
                                                  await ref
                                                      .watch(servicesProvider)
                                                      .getTerapiaSeleccionada(
                                                          0);
                                              ref
                                                  .read(indexTerapiaProvider
                                                      .notifier)
                                                  .state = 0;
                                              ref
                                                  .watch(countdownProvider)
                                                  .volver(true);
                                              context.pop();
                                            }
                                          },
                                          child: const Text('Guardar',
                                              style: TextStyle(
                                                  color: Colors.white)))
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                ),
                //const SizedBox(height: 4),
                Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.5,
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
                                    .read(origenHomeZapperProvider.notifier)
                                    .state = false;
                              });
                            }
                            return GridView.builder(
                                controller: _scroll,
                                itemCount: snapshot.data?.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: heightScreen * 0.005,
                                        //crossAxisSpacing: 8,
                                        //mainAxisSpacing: 12,
                                        crossAxisCount: 1),
                                itemBuilder: (context, index) {
                                  if (ref
                                      .watch(countdownProvider)
                                      .volvioDeTimerZapperScreen) {
                                    ref.watch(countdownProvider).volver(false);
                                    _scroll.jumpTo(
                                        _scroll.position.minScrollExtent);
                                  }
                                  return CustomTherapy(
                                    name: snapshot.data![index].nombre,
                                    frecMin: snapshot.data![index].frecMin,
                                    frecMax: snapshot.data![index].frecMax,
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
        floatingActionButton: FloatingActionButton(
          //elevation: 3,
          tooltip: 'Siguiente',
          shape: const StadiumBorder(),
          backgroundColor: Colors.blue,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  InputDecoration formDecorationTerapia(
      String titleLabel, String suffixText, String? hintText) {
    return InputDecoration(
      labelText: titleLabel,
      labelStyle: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white70),
      suffixText: suffixText,
      suffixStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 4),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(16))),
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
      padding: const EdgeInsets.only(top: 9, bottom: 23, left: 16, right: 16),
      decoration: const BoxDecoration(
          //borderRadius: BorderRadius.circular(45),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/icons/icono9.png'))),
      child: FilledButton(
          style: ButtonStyle(
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(25, 23)))),
              backgroundColor: ref.watch(indexTerapiaProvider) == terapiaSel
                  ? const MaterialStatePropertyAll(
                      Color.fromARGB(255, 50, 102, 175))
                  : const MaterialStatePropertyAll(Colors.transparent)),
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
    );
  }
}
