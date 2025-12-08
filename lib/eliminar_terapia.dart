import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> eliminarTerapia(BuildContext context, double heightScreen,
    double widthScreen, WidgetRef ref) {
  return showDialog(
      //barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: heightScreen * 0.214,
                          maxWidth: widthScreen * 0.783),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: heightScreen * 0.214,
                          maxWidth: widthScreen * 0.783),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(30),
                          gradient: gradientAlertDialog()),
                      child: Container(),
                    ),
                  ),
                ),
                AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
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
                            side: MaterialStatePropertyAll(BorderSide(
                          color: Colors.white,
                        ))),
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('NO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    TextButton(
                        style: const ButtonStyle(
                            side: MaterialStatePropertyAll(BorderSide(
                          color: Colors.white,
                        ))),
                        onPressed: () async {
                          final int id =
                              ref.watch(terapiaProvider0).idTerapiaPersonal;
                          await ref
                              .watch(servicesProvider)
                              .deleteTerapiaPersonal(id);
                          await ref
                              .watch(servicesProvider)
                              .cargarTerapiaTotal();
                          ref.read(terapiaProvider0.notifier).state = await ref
                              .watch(servicesProvider)
                              .getTerapiaSeleccionada(0);

                          ref.read(origenHomeZapperProvider.notifier).state =
                              true;
                          ref.read(indexTerapiaProvider.notifier).state = 0;
                          ref.read(isComingFromSomeTimerScreen.notifier).state =
                              true;
                          context.pop();
                        },
                        child: const Text('SI',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ],
            ),
          ));
}
