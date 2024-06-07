import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];
  CollectionReference collectionReferenceUsers = db.collection('usuarios');
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();
  for (var element in queryUsers.docs) {
    users.add(element.data());
  }
  return users;
}

Future<void> addUser(
  String nombre,
  String apellido,
  String edad,
  String sexo,
  String telefono1,
  String telefono2,
  //String correo,
  String instagram,
  String pais,
  String provincia,
  //String clave,
  //String confirmarClave
) async {
  await db.collection('usuarios').add({
    'Nombre': nombre,
    'Apellido': apellido,
    'Edad': edad,
    'Sexo': sexo,
    'Teléfono 1': telefono1,
    'Teléfono 2': telefono2,
    //'Correo': correo,
    'Instagra': instagram,
    'País': pais,
    'Estado / Provincia': provincia,
    //'Contraseña': clave,
    //'Confirmar Contraseña': confirmarClave
  });
}
