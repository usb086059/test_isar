import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/form_decoration_terapia.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SetNameMyDevice extends ConsumerWidget {
  final Device data;
  final GlobalKey<FormState> formKey;
  final bool editEnable;
  const SetNameMyDevice(
      {super.key,
      required this.data,
      required this.formKey,
      required this.editEnable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    //final formKey = GlobalKey<FormState>();
    final TextEditingController nombreDeviceController =
        TextEditingController.fromValue(TextEditingValue(
            text: data.nombre == 'Sin nombre' ? '' : data.nombre,
            selection: TextSelection.collapsed(
                offset: data.nombre == 'Sin nombre' ? 0 : data.nombre.length)));
    final isEnabledButtonConectar = ref.watch(isEnabledButtonConectarProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        } else {
          ref.read(isScanEnabledProvider.notifier).state = true;
          ref.read(isEnabledButtonConectarProvider.notifier).state = true;
          context.pop();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: SingleChildScrollView(
              child: Stack(children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: heightScreen * 0.3638,
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
                          maxHeight: heightScreen * 0.3638,
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
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          'Asigne un nombre al equipo',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 10,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            controller: nombreDeviceController,
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
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        style: const ButtonStyle(
                            side: MaterialStatePropertyAll(BorderSide(
                          color: Colors.white,
                        ))),
                        onPressed: () {
                          ref.read(isScanEnabledProvider.notifier).state = true;
                          ref
                              .read(isEnabledButtonConectarProvider.notifier)
                              .state = true;
                          /* ref
                                                                                  .watch(
                                                                                      origenHomeZapperProvider
                                                                                          .notifier)
                                                                                  .state = true; */
                          context.pop();
                        },
                        child: const Text('Volver',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    TextButton(
                        style: const ButtonStyle(
                            side: MaterialStatePropertyAll(BorderSide(
                          color: Colors.white,
                        ))),
                        onPressed: isEnabledButtonConectar
                            ? () async {
                                if (formKey.currentState!.validate()) {
                                  ref
                                      .read(isEnabledButtonConectarProvider
                                          .notifier)
                                      .state = false;
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: const Color.fromARGB(
                                              255, 50, 102, 175),
                                          backgroundColor: Colors.purple[300],
                                        ));
                                      });
                                  data.nombre =
                                      nombreDeviceController.text.toUpperCase();
                                  data.conectado = true;
                                  data.relojAsignado = 0;
                                  if (editEnable) {
                                    await ref
                                        .read(servicesProvider)
                                        .editDevice(data);
                                  } else {
                                    await ref
                                        .read(servicesProvider)
                                        .addDevice(data);
                                  }

                                  ref
                                      .read(deviceProvider.notifier)
                                      .update((state) => data);
                                  await ref
                                      .read(bleProvider)
                                      .conectar(data.mac);
                                  if (!context.mounted) return;
                                  context.pop();
                                  if (!context.mounted) return;
                                  context.pop();
                                }
                              }
                            : null,
                        child: const Text('Conectar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
