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

Future<void> addUser(String name) async {
  await db.collection('usuarios').add({'name': name});
}
