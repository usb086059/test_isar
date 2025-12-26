import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
//import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formKey = GlobalKey<FormState>();
final nombreController = TextEditingController();
final apellidoController = TextEditingController();
final edadController = TextEditingController();
final telefonoController = TextEditingController();
final paisController = TextEditingController();
final provinciaController = TextEditingController();

String googleID = '';
String nombre = '';
String apellido = '';
String edad = '';
String telefono = '';
String pais = '';
String provincia = '';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double heightContainerForm = heightScreen * 0.7;
    double widthContainerForm = widthScreen * 0.75;
    double heightCeldaForm = heightScreen * 0.06;
    double widthCeldaForm = widthScreen * 0.6;
    var user = FirebaseAuth.instance.currentUser;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Center(
                    child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 50, 102, 175),
                  backgroundColor: Colors.purple[300],
                ));
              });
          await signOutWithGoogle();
          if (!context.mounted) return;
          context.pop();
          if (!context.mounted) return;
          context.pop();
        }
      },
      child: SafeArea(
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/fondo3.jpg'))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        constraints: BoxConstraints(
                            maxHeight: heightContainerForm,
                            maxWidth: widthContainerForm),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
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
                            maxHeight: heightContainerForm,
                            maxWidth: widthContainerForm),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(30),
                            gradient: gradientRegistro()),
                        child: Container(),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: heightContainerForm,
                      width: widthContainerForm,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: heightScreen * 0.09,
                                width: widthScreen * 0.5,
                                alignment: Alignment.center,
                                child: const Text(
                                  'REGISTRO',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: heightCeldaForm,
                                width: widthCeldaForm,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 15,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  controller: nombreController,
                                  keyboardType: TextInputType.text,
                                  decoration: formDecoration('Nombre'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: heightCeldaForm,
                                width: widthCeldaForm,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 15,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  controller: apellidoController,
                                  keyboardType: TextInputType.text,
                                  decoration: formDecoration('Apellido'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: heightCeldaForm,
                                width: widthCeldaForm,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 2,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  controller: edadController,
                                  keyboardType: TextInputType.number,
                                  decoration: formDecoration('Edad'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    } else {
                                      final int? isInt = int.tryParse(value);
                                      if (isInt == null) {
                                        return 'No Letras';
                                      } else if (isInt < 0) {
                                        return 'No (-)';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: heightCeldaForm,
                                width: widthCeldaForm,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 15,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  controller: telefonoController,
                                  keyboardType: TextInputType.phone,
                                  decoration: formDecoration('Teléfono'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    } else {
                                      final int? isInt = int.tryParse(value);
                                      if (isInt == null) {
                                        return 'No Letras';
                                      } else if (isInt < 0) {
                                        return 'No (-)';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: heightCeldaForm,
                                width: widthCeldaForm,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 15,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  controller: paisController,
                                  keyboardType: TextInputType.text,
                                  decoration: formDecoration('País'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: heightCeldaForm,
                                width: widthCeldaForm,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  maxLength: 15,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  controller: provinciaController,
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      formDecoration('Estado / Provincia'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                  width: widthScreen * 0.5,
                                  height: heightScreen * 0.07,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStatePropertyAll(Size(
                                                      widthScreen * 0.23,
                                                      heightScreen * 0.06)),
                                              side:
                                                  const MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: Colors.white,
                                                          width: 6)),
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.transparent)),
                                          onPressed: () async {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: const Color.fromARGB(
                                                        255, 50, 102, 175),
                                                    backgroundColor:
                                                        Colors.purple[300],
                                                  ));
                                                });
                                            await signOutWithGoogle();
                                            if (!context.mounted) return;
                                            context.pop();
                                            if (!context.mounted) return;
                                            context.pop();
                                          },
                                          child: const Text(
                                            'Volver',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      TextButton(
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStatePropertyAll(Size(
                                                      widthScreen * 0.23,
                                                      heightScreen * 0.06)),
                                              side:
                                                  const MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: Colors.white,
                                                          width: 6)),
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.transparent)),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              50,
                                                              102,
                                                              175),
                                                      backgroundColor:
                                                          Colors.purple[300],
                                                    ));
                                                  });
                                              /* ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text('Bien Hecho'))); */
                                              googleID = user!.uid;
                                              nombre = nombreController.text;
                                              apellido =
                                                  apellidoController.text;
                                              edad = edadController.text;
                                              telefono =
                                                  telefonoController.text;
                                              pais = paisController.text;
                                              provincia =
                                                  provinciaController.text;
                                              await addUser(
                                                  googleID,
                                                  nombre,
                                                  apellido,
                                                  edad,
                                                  telefono,
                                                  pais,
                                                  provincia);
                                              if (context.mounted) {
                                                context.pop();
                                                context.pop();
                                                //context.go('/bluetooth');
                                              }
                                            }
                                          },
                                          child: const Text('Guardar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration formDecoration(String titleLabel) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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
      labelText: titleLabel,
    );
  }
}
