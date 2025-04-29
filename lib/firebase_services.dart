import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
//import "package:flutter/material.dart";
//import "package:go_router/go_router.dart";

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

Future<String> getContacto(String contacto) async {
  List listContactos = [];
  String url;
  CollectionReference collectionReferenceContactos = db.collection('contacto');
  QuerySnapshot queryListContactos = await collectionReferenceContactos
      .where('nombre', isEqualTo: contacto)
      .get();
  for (var element in queryListContactos.docs) {
    listContactos.add(element.data());
  }
  url = listContactos[0]['url'];
  return url;
}

Future<void> addUser(
  String googleID,
  String nombre,
  String apellido,
  String edad,
  String telefono,
  String pais,
  String provincia,
) async {
  await db.collection('usuarios').add({
    'googleID': googleID,
    'Nombre': nombre,
    'Apellido': apellido,
    'Edad': edad,
    'Teléfono': telefono,
    'País': pais,
    'Estado / Provincia': provincia,
  });
}

ImageProvider<Object> userImage(/* User? user, bool localUserImagen */) {
  User? currentUser = FirebaseAuth.instance.currentUser;
  ImageProvider<Object> imagen = const AssetImage('assets/logo-google-G.png');
  if (currentUser != null) {
    if (currentUser.photoURL == null || currentUser.photoURL!.isEmpty) {
      imagen = const AssetImage('assets/icons/iconoCircular.png');
    } else {
      imagen = NetworkImage(currentUser.photoURL!);
    }
  }
  return imagen;
}
