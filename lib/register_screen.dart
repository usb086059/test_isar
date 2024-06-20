import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();
final nombreController = TextEditingController();
final apellidoController = TextEditingController();
final edadController = TextEditingController();
final sexoController = TextEditingController();
final telefono1Controller = TextEditingController();
final telefono2Controller = TextEditingController();
//final correoController = TextEditingController();
final instagramController = TextEditingController();
final paisController = TextEditingController();
final provinciaController = TextEditingController();
//final claveController = TextEditingController();
//final confirmarClaveController = TextEditingController();
String googleID = '';
String nombre = '';
String apellido = '';
String edad = '';
String sexo = '';
String telefono1 = '';
String telefono2 = '';
//String correo = '';
String instagram = '';
String pais = '';
String provincia = '';
//String clave = '';
//String confirmarClave = '';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Registro'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: nombreController,
                            keyboardType: TextInputType.text,
                            decoration: formDecoration('Nombre'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: apellidoController,
                            keyboardType: TextInputType.text,
                            decoration: formDecoration('Apellido'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su apellido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: edadController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                labelText: 'Edad',
                                labelStyle: TextStyle(fontSize: 25)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su edad';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownMenu(
                            controller: sexoController,
                            width: MediaQuery.of(context).size.width * 0.45,
                            inputDecorationTheme: const InputDecorationTheme(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                labelStyle: TextStyle(fontSize: 25)),
                            enableSearch: false,
                            initialSelection: 'Woman',
                            label: const Text('Sexo'),
                            dropdownMenuEntries: const <DropdownMenuEntry<
                                String>>[
                              DropdownMenuEntry(value: 'Woman', label: 'Mujer'),
                              DropdownMenuEntry(value: 'Man', label: 'Hombre')
                            ]),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: telefono1Controller,
                            keyboardType: TextInputType.phone,
                            decoration: formDecoration('Teléfono 1'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su teléfono';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: telefono2Controller,
                            keyboardType: TextInputType.phone,
                            decoration: formDecoration('Teléfono 2'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su teléfono';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextFormField(
                        controller: instagramController,
                        keyboardType: TextInputType.text,
                        decoration: formDecoration('Instagram'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su instagram';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextFormField(
                        controller: paisController,
                        keyboardType: TextInputType.text,
                        decoration: formDecoration('País'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su país';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextFormField(
                        controller: provinciaController,
                        keyboardType: TextInputType.text,
                        decoration: formDecoration('Estado / Provincia'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su estado / provincia';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const NewElevatedButton(),
                    const SizedBox(height: 30),
                    FilledButton.tonalIcon(
                        onPressed: () async {
                          if (user != null) {
                            await FirebaseAuth.instance.signOut();
                            context.go('/login');
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Cerrar Sesión'))
                  ],
                ),
              ),
            )));
  }

  InputDecoration formDecoration(String titleLabel) {
    return InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        labelText: titleLabel,
        labelStyle: const TextStyle(fontSize: 25));
  }
}

class NewElevatedButton extends StatelessWidget {
  const NewElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(150.0, 50.0)),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Bien Hecho')));
            googleID = user!.uid;
            nombre = nombreController.text;
            apellido = apellidoController.text;
            edad = edadController.text;
            sexo = sexoController.text;
            telefono1 = telefono1Controller.text;
            telefono2 = telefono2Controller.text;
            //correo = correoController.text;
            instagram = instagramController.text;
            pais = paisController.text;
            provincia = provinciaController.text;
            //clave = claveController.text;
            //confirmarClave = confirmarClaveController.text;
            addUser(googleID, nombre, apellido, edad, sexo, telefono1,
                telefono2, instagram, pais, provincia);

            context.push('/devices');
          }
        },
        child: const Text('Aceptar'));
  }
}
