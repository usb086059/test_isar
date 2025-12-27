import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/aviso_error_conexion.dart';
import 'package:flutter_application_1/form_decoration_terapia.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> editarTerapia(
    BuildContext context,
    double heightScreen,
    double widthScreen,
    GlobalKey<FormState> formKey,
    TextEditingController nombreEditarTerapiaController,
    TextEditingController frecMinimaEditarTerapiaController,
    TextEditingController frecMaximaEditarTerapiaController,
    TextEditingController descripcionEditarTerapiaController,
    WidgetRef ref) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Material(
            color: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: heightScreen * 0.7,
                            maxWidth: widthScreen * 0.75),
                        height: heightScreen * 0.7,
                        width: widthScreen * 0.75,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                            gradient: gradientAlertDialog()),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Editar Terapia',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 25,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  controller: nombreEditarTerapiaController,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      formDecorationTerapia('Nombre', '', null),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widthScreen * 0.31,
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        maxLength: 3,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller:
                                            frecMinimaEditarTerapiaController,
                                        keyboardType: TextInputType.number,
                                        decoration: formDecorationTerapia(
                                            'Frecuencia', 'KHz', 'Mínima'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Requerido';
                                          } else {
                                            final int? isInt =
                                                int.tryParse(value);
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
                                    SizedBox(
                                      width: widthScreen * 0.31,
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        maxLength: 3,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller:
                                            frecMaximaEditarTerapiaController,
                                        keyboardType: TextInputType.number,
                                        decoration: formDecorationTerapia(
                                            'Frecuencia', 'KHz', 'Máxima'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Requerido';
                                          } else {
                                            final int? isInt =
                                                int.tryParse(value);
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
                                      AutovalidateMode.onUserInteraction,
                                  maxLines: 5,
                                  maxLength: 200,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  controller:
                                      descripcionEditarTerapiaController,
                                  keyboardType: TextInputType.text,
                                  decoration: formDecorationTerapia(
                                      'Descripción', '', null),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        style: const ButtonStyle(
                                            side: WidgetStatePropertyAll(
                                                BorderSide(
                                          color: Colors.white,
                                        ))),
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    TextButton(
                                        style: const ButtonStyle(
                                            side: WidgetStatePropertyAll(
                                                BorderSide(
                                          color: Colors.white,
                                        ))),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            // Esconder teclado
                                            FocusScope.of(context).unfocus();
                                            // Espera mientras se esconde el teclado
                                            await Future.delayed(
                                                const Duration(seconds: 1));
                                            int? fMin = int.tryParse(
                                                frecMinimaEditarTerapiaController
                                                    .text);
                                            int? fMax = int.tryParse(
                                                frecMaximaEditarTerapiaController
                                                    .text);
                                            if (fMin! > fMax!) {
                                              if (!context.mounted) return;
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return const AvisoErrorConexion(
                                                        title:
                                                            'Rango de Frecuencia',
                                                        content:
                                                            'Frecuencia Máxima debe ser mayor que Frecuencia Mínima');
                                                  });
                                              await Future.delayed(
                                                  const Duration(seconds: 6));
                                              if (!context.mounted) return;
                                              context.pop();
                                            } else {
                                              TerapiaTotal newTerapiaPersonal =
                                                  await ref
                                                      .watch(terapiaProvider0);
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
                                              newTerapiaPersonal.editable =
                                                  true;
                                              await ref
                                                  .watch(servicesProvider)
                                                  .editTerapiaPersonal(
                                                      newTerapiaPersonal);
                                              await ref
                                                  .watch(servicesProvider)
                                                  .cargarTerapiaTotal();
                                              ref
                                                      .read(terapiaProvider0
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
                                                  .read(
                                                      isComingFromSomeTimerScreen
                                                          .notifier)
                                                  .state = true;
                                              if (!context.mounted) return;
                                              context.pop();
                                            }
                                          }
                                        },
                                        child: const Text('Guardar',
                                            style:
                                                TextStyle(color: Colors.white)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ),
              ),
            ),
          ));
}
