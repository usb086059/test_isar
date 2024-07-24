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
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
                //const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: heightScreen * 0.35,
                      maxWidth: widthScreen * 0.95),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FittedBox(
                            //alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(selectModoProvider.notifier).state =
                                    true;
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                elevation: 10,
                                color: modoSeleccionado
                                    ? Colors.blue
                                    : Colors.white,
                                shadowColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('POR TANDAS',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: modoSeleccionado
                                                  ? Colors.white
                                                  : null,
                                              fontWeight: FontWeight.bold)),
                                      DataTable(
                                          headingTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: modoSeleccionado
                                                  ? Colors.white
                                                  : null,
                                              fontWeight: FontWeight.bold),
                                          dataTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: modoSeleccionado
                                                  ? Colors.white
                                                  : null),
                                          columnSpacing: 17,
                                          columns: const [
                                            DataColumn(
                                                label: Text(
                                                  'CICLOS',
                                                ),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('ON  '),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('OFF  '),
                                                numeric: true),
                                          ],
                                          rows: const [
                                            DataRow(cells: [
                                              DataCell(Text('1     ')),
                                              DataCell(Text('7 min')),
                                              DataCell(Text('20 min')),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(Text('2     ')),
                                              DataCell(Text('7 min')),
                                              DataCell(Text('20 min')),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(Text('3     ')),
                                              DataCell(Text('7 min')),
                                              DataCell(Text('FIN  ')),
                                            ])
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(selectModoProvider.notifier).state =
                                    false;
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                elevation: 10,
                                color: modoSeleccionado
                                    ? Colors.white
                                    : Colors.blue,
                                shadowColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('CONTINUO',
                                          style: TextStyle(
                                              color: modoSeleccionado
                                                  ? null
                                                  : Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      DataTable(
                                          headingTextStyle: TextStyle(
                                              color: modoSeleccionado
                                                  ? null
                                                  : Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          dataTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: modoSeleccionado
                                                  ? null
                                                  : Colors.white),
                                          columnSpacing: 17,
                                          columns: const [
                                            DataColumn(
                                                label: Text('CICLOS'),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('ON   '),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('OFF'),
                                                numeric: true),
                                          ],
                                          rows: const [
                                            DataRow(cells: [
                                              DataCell(Text('1     ')),
                                              DataCell(Text('60 min')),
                                              DataCell(Text('FIN')),
                                            ]),
                                            /* DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('7')),
                                          DataCell(Text('20')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('7')),
                                          DataCell(Text('20')),
                                        ]) */
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.blue[50]),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'TERAPIAS',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        color: Colors.blue,
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
                        color: Colors.blue,
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
                        color: Colors.blue,
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
                        maxHeight: heightScreen * 0.55,
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
                                        childAspectRatio:
                                            heightScreen * 0.00185,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 12,
                                        crossAxisCount: 2),
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
      //padding: EdgeInsets.symmetric(horizontal: 8.5, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 0,
                blurStyle: BlurStyle.normal)
          ],
          image: const DecorationImage(
              /* colorFilter:
                  ColorFilter.mode(Colors.lightBlueAccent, BlendMode.modulate), */
              fit: BoxFit.fill,
              image: AssetImage('assets/icons/ovalo.png'))),
      child: Card(
          color: ref.watch(indexTerapiaProvider) == terapiaSel
              ? Colors.lightBlueAccent
              : Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(33))),
          //elevation: 10,
          //color: Colors.blue,
          //shadowColor: Colors.cyanAccent,
          child: Container(
            //color: Colors.green,
            alignment: Alignment.center,
            child: ListTile(
              isThreeLine: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 14),

              //splashColor: Colors.blue,
              onTap: () async {
                ref.read(indexTerapiaProvider.notifier).state = terapiaSel;
                ref.read(terapiaProvider.notifier).state = await ref
                    .watch(servicesProvider)
                    .getTerapiaSeleccionada(terapiaSel);
              },
              //leading: const Icon(Icons.arrow_forward_ios),
              // trailing: const Icon(
              //   Icons.favorite,
              //   size: 10,
              // ),
              title: Text(
                name,
                style: TextStyle(
                    color: ref.watch(indexTerapiaProvider) == terapiaSel
                        ? Colors.white
                        : null,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '$frecMin KHz - $frecMax KHz',
                style: TextStyle(
                    color: ref.watch(indexTerapiaProvider) == terapiaSel
                        ? Colors.white
                        : null,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )),
    );
  }
}
