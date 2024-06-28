import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getGoogleID() async {
  List listGoogleID = [];
  CollectionReference collectionReferenceUsers = db.collection('usuarios');
  QuerySnapshot queryListGoogleID = await collectionReferenceUsers.get();
  for (var element in queryListGoogleID.docs) {
    listGoogleID.add(element.get('googleID'));
  }
  return listGoogleID;
}

/* Future<List> getUsers() async {
  List users = [];
  CollectionReference collectionReferenceUsers = db.collection('usuarios');
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();
  for (var element in queryUsers.docs) {
    users.add(element.data());
  }
  return users;
} */

Future<List> getTerapias() async {
  List terapias = [];
  CollectionReference collectionReferenceTerapias = db.collection('terapias');
  QuerySnapshot queryTerapias = await collectionReferenceTerapias.get();
  for (var element in queryTerapias.docs) {
    terapias.add(element.data());
  }
  return terapias;
}

Future<void> addUser(
  String googleID,
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
    'googleID': googleID,
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
