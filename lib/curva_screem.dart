import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_1/curve_services.dart';
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

class CurvaScreen extends ConsumerWidget {
  const CurvaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(gradient: purpleGradientCurvas()),
          ),
          ClipPath(
            clipper: LoginCurve(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: azulCorteGradient()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          ClipPath(
            clipper: Corte3(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration:
                  BoxDecoration(gradient: azulGradientFloatingActionButton()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          /* Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration:
                BoxDecoration(gradient: azulGradientFloatingActionButton()),
            //height: 100,

            //color: Colors.blue.withOpacity(0.3),
          ), */
          ClipPath(
            clipper: Corte4(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: loginPurpleGradientCurvas()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          ClipPath(
            clipper: Corte5(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: purpleGradientCurvas()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          ClipPath(
            clipper: Corte6(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: purpleGradientVolverButton()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          ClipPath(
            clipper: Corte7(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: loginPurpleGradientCurvas()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          ClipPath(
            clipper: Corte9(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: gradientAlertDialog()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          ClipPath(
            clipper: Corte8(),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(gradient: loginPurpleGradientCurvas()),
              //height: 100,

              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/fondo3.jpg'))),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            /* appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text('REGISTRO'),
              titleTextStyle: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  //color: Color.fromARGB(255, 50, 102, 175),
                  fontWeight: FontWeight.bold),
            ), */
            body: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: heightScreen * 0.9,
                          maxWidth: widthScreen * 0.6),
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
                          maxHeight: heightScreen * 0.9,
                          maxWidth: widthScreen * 0.6),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(30),
                          gradient: gradientRegistro()),
                      child: Container(),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: heightScreen * 0.9,
                    width: widthScreen * 0.6,
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
                                    //color: Color.fromARGB(255, 50, 102, 175),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: heightScreen * 0.06,
                              width: widthScreen * 0.5,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                //maxLength: 25,
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
                                    return 'Dato Requerido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: widthScreen * 0.5,
                              height: heightScreen * 0.06,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                //maxLength: 25,
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
                                    return 'Dato Requerido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: widthScreen * 0.5,
                              height: heightScreen * 0.06,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                //maxLength: 25,
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
                                    return 'Dato Requerido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: widthScreen * 0.5,
                              height: heightScreen * 0.06,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                //maxLength: 25,
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
                                    return 'Dato Requerido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: widthScreen * 0.5,
                              height: heightScreen * 0.06,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                //maxLength: 25,
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
                                    return 'Dato Requerido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: widthScreen * 0.5,
                              height: heightScreen * 0.06,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization:
                                    TextCapitalization.characters,
                                //maxLength: 25,
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
                                    return 'Dato Requerido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                                width: widthScreen * 0.5,
                                height: heightScreen * 0.07,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        style: ButtonStyle(
                                            fixedSize: MaterialStatePropertyAll(
                                                Size(widthScreen * 0.21,
                                                    heightScreen * 0.06)),
                                            /* shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))), */
                                            side: MaterialStatePropertyAll(
                                                BorderSide(
                                                    color: Colors.white,
                                                    width: 6)),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.transparent)),
                                        onPressed: () {},
                                        child: Text(
                                          'Volver',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    TextButton(
                                        style: ButtonStyle(
                                            fixedSize: MaterialStatePropertyAll(
                                                Size(widthScreen * 0.21,
                                                    heightScreen * 0.06)),
                                            /* shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))), */
                                            side: MaterialStatePropertyAll(
                                                BorderSide(
                                                    color: Colors.white,
                                                    width: 6)),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.transparent)),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content:
                                                        Text('Bien Hecho')));
                                            googleID = user!.uid;
                                            nombre = nombreController.text;
                                            apellido = apellidoController.text;
                                            edad = edadController.text;
                                            telefono = telefonoController.text;
                                            pais = paisController.text;
                                            provincia =
                                                provinciaController.text;
                                            addUser(
                                                googleID,
                                                nombre,
                                                apellido,
                                                edad,
                                                telefono,
                                                pais,
                                                provincia);

                                            context.push('/devices');
                                          }
                                        },
                                        child: Text('Guardar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                )),
                            /* Container(
                              width: widthScreen * 0.44,
                              //height: heightScreen * 0.06,
                              child: DropdownMenu(
                                  width: widthScreen * 0.44,
                                  textStyle: TextStyle(fontSize: 10),
                                  controller: sexoController,
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          labelStyle:
                                              TextStyle(fontSize: 18)),
                                  enableSearch: false,
                                  initialSelection: 'Woman',
                                  label: const Text('Sexo'),
                                  dropdownMenuEntries: const <DropdownMenuEntry<
                                      String>>[
                                    DropdownMenuEntry(
                                        value: 'Woman', label: 'Mujer'),
                                    DropdownMenuEntry(
                                        value: 'Man', label: 'Hombre')
                                  ]),
                            ), */
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /* bottomNavigationBar: Container(
                height: heightScreen * 0.1,
                /* decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))), */
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    widthScreen * 0.28, heightScreen * 0.065)),
                            onPressed: () {},
                            child: const Text('Volver')),
                        NewElevatedButton(
                          width: widthScreen * 0.28,
                          height: heightScreen * 0.065,
                          texto: 'Aceptar',
                        ),
                      ],
                    ),
                  ],
                )), */
          ),
        ],
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

class NewElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final String texto;
  const NewElevatedButton(
      {super.key,
      required this.width,
      required this.height,
      required this.texto});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: Size(width, height)),
        onPressed: () {},
        child: Text(texto));
  }
}

class Corte3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width * 0.5, 0);
    path.arcToPoint(
      Offset(size.width, size.height * 0.206),
      radius: const Radius.circular(270),
      clockwise: true,
    );

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Corte4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //path.lineTo(0, size.height * 0.3);
    path.arcToPoint(
      Offset(size.width * 0.3, size.height * 0.150),
      radius: const Radius.circular(105),
      clockwise: false,
    );
    path.arcToPoint(
      Offset(size.width * 0.0, size.height * 0.1),
      radius: const Radius.circular(150),
      clockwise: true,
    );
    path.lineTo(size.width * 0.0, size.height * 0.0);
    /* path.lineTo(size.width * 0.4, size.height * 0.35);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.5),
      radius: const Radius.circular(130),
      clockwise: true,
    ); */

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Corte5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.412);
    path.arcToPoint(
      Offset(size.width, size.height * 1),
      radius: const Radius.circular(900),
      clockwise: false,
    );
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Corte6 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.arcToPoint(
      Offset(size.width, size.height * 0.8),
      radius: const Radius.circular(400),
      clockwise: false,
    );
    path.lineTo(size.width, size.height * 0.75);
    path.arcToPoint(
      Offset(size.width, size.height * 0.206),
      radius: const Radius.circular(500),
      clockwise: true,
    );
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Corte7 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0, size.height * 0.3);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.8),
      radius: const Radius.circular(90),
      clockwise: true,
    );
    path.lineTo(size.width * 0, size.height * 0.78);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.25),
      radius: const Radius.circular(50),
      clockwise: false,
    );
    path.lineTo(size.width * 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Corte8 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0, size.height * 0.7);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.35),
      radius: const Radius.circular(40),
      clockwise: false,
    );
    path.lineTo(size.width * 0, size.height * 0.35);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.65),
      radius: const Radius.circular(90),
      clockwise: true,
    );
    path.lineTo(size.width * 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Corte9 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * 0, size.height * 0.702);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.35),
      radius: const Radius.circular(40),
      clockwise: false,
    );
    path.lineTo(size.width * 0, size.height * 0.35);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0.645),
      radius: const Radius.circular(90),
      clockwise: true,
    );
    path.lineTo(size.width * 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
