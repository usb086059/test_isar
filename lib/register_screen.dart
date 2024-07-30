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
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          height: heightScreen,
          width: widthScreen,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('assets/fondo557.jpg'))),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: const Text('Registro'),
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              body: Container(
                height: heightScreen,
                width: widthScreen,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: widthScreen * 0.44,
                                child: TextFormField(
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
                              Container(
                                width: widthScreen * 0.44,
                                child: TextFormField(
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
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: widthScreen * 0.44,
                                child: TextFormField(
                                  controller: edadController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      labelText: 'Edad',
                                      labelStyle: TextStyle(fontSize: 25)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Dato Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              DropdownMenu(
                                  controller: sexoController,
                                  width: widthScreen * 0.44,
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          labelStyle: TextStyle(fontSize: 25)),
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
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: widthScreen * 0.44,
                                child: TextFormField(
                                  controller: telefono1Controller,
                                  keyboardType: TextInputType.phone,
                                  decoration: formDecoration('Teléfono 1'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Dato Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: widthScreen * 0.44,
                                child: TextFormField(
                                  controller: telefono2Controller,
                                  keyboardType: TextInputType.phone,
                                  decoration: formDecoration('Teléfono 2'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Dato Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: widthScreen * 0.85,
                            child: TextFormField(
                              controller: instagramController,
                              keyboardType: TextInputType.text,
                              decoration: formDecoration('Instagram'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Dato Requerido';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: widthScreen * 0.85,
                            child: TextFormField(
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
                            height: 30,
                          ),
                          Container(
                            width: widthScreen * 0.85,
                            child: TextFormField(
                              controller: provinciaController,
                              keyboardType: TextInputType.text,
                              decoration: formDecoration('Estado / Provincia'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Dato Requerido';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(150.0, 50.0)),
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('Volver')),
                              const NewElevatedButton(),
                            ],
                          ),
                          const SizedBox(height: 30),
                          /* FilledButton.tonalIcon(
                              onPressed: () async {
                                if (user != null) {
                                  await FirebaseAuth.instance.signOut();
                                  context.go('/login');
                                }
                              },
                              icon: const Icon(Icons.logout),
                              label: const Text('Cerrar Sesión')) */
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ));
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
