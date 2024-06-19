import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:go_router/go_router.dart';
//import 'package:flutter_application_1/firebase_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonalIcon(
                onPressed: () async {
                  final user = await signInWithGoogle();
                  if (user.user != null) {
                    context.push('/register');
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Continua con Google')),
            Text('asdas')
          ],
        ),
      )

          /* FutureBuilder(
              future: getUsers(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Text(snapshot.data?[index]['nombre']);
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })) */
          ),
    );
  }
}
