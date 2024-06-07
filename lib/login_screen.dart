import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder(
              future: getUsers(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Text(snapshot.data?[index]['name']);
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }))),
    );
  }
}
