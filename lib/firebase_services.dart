import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
//import "package:flutter/material.dart";
//import "package:go_router/go_router.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

/* Future<List> getGoogleID() async {
  List listGoogleID = [];
  CollectionReference collectionReferenceUsers = db.collection('usuarios');
  QuerySnapshot queryListGoogleID = await collectionReferenceUsers.get();
  for (var element in queryListGoogleID.docs) {
    listGoogleID.add(element.get('googleID'));
  }

  return listGoogleID;
} */

Future<bool> userIsRegistered(String userId) async {
  DocumentSnapshot document = await db.collection('usuarios').doc(userId).get();
  return document.exists;
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
  try {
    QuerySnapshot queryListContactos = await collectionReferenceContactos
        .where('nombre', isEqualTo: contacto)
        .get(const GetOptions(source: Source.server))
        .timeout(const Duration(seconds: 3));
    for (var element in queryListContactos.docs) {
      listContactos.add(element.data());
    }
    url = listContactos[0]['url'];
  } on TimeoutException catch (_) {
    url = 'error';
    print('************************************* error Timeout');
  } catch (e) {
    url = 'error';
    print(
        '************************ Error al obtener la lista de contactos (sin internet?: $e)');
  }

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
  await db.collection('usuarios').doc(googleID).set({
    //'googleID': googleID,
    'Nombre': nombre,
    'Apellido': apellido,
    'Edad': edad,
    'Teléfono': telefono,
    'País': pais,
    'Estado / Provincia': provincia,
  });
}

ImageProvider<Object> userImage(String imagePath) {
  if (imagePath.startsWith('http')) {
    return NetworkImage(imagePath);
  }

  if (imagePath == 'assets/icons/iconUserNoImage.png') {
    return const AssetImage('assets/icons/iconUserNoImage.png');
  } else {
    return const AssetImage('assets/icons/iconoCircular.png');
  }
}
