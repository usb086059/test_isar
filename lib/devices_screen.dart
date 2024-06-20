import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    final String nameUser = user!.displayName!;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(backgroundImage: NetworkImage(user.photoURL!)),
          ),
          centerTitle: false,
          title: Text(nameUser),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                const Card(
                  child: ListTile(
                    title: Text('PEDILUVIO'),
                    textColor: Colors.white,
                    tileColor: Colors.blue,
                    iconColor: Colors.white,
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.menu),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('ZAPPER'),
                    textColor: Colors.white,
                    tileColor: Colors.blue,
                    iconColor: Colors.white,
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.menu),
                    onTap: () {
                      context.push('/home');
                    },
                  ),
                ),
                const Card(
                  child: ListTile(
                    title: Text('DERMATRONIC'),
                    textColor: Colors.white,
                    tileColor: Colors.blue,
                    iconColor: Colors.white,
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.menu),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
