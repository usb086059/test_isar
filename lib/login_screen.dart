import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Card(
                  color: Colors.blue,
                  child: Image.asset(
                      'assets/avt-logo-vectorizado-en-dorado-y-blanco-02-1-600x178.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'BIENVENIDO',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Text(
                    'Somos AVTechnology, una empresa especializada en equipos terapéuticos y de cuidado personal.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 150),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Text(
                    'Inicie sesión con una cuenta de Google',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton.tonalIcon(
                    style: const ButtonStyle(
                        textStyle:
                            MaterialStatePropertyAll(TextStyle(fontSize: 20)),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 219, 239, 255)),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: () async {
                      final user = await signInWithGoogle();
                      if (user.user != null) {
                        final List googleID = await getGoogleID();
                        final String estaRegistrado = googleID.firstWhere(
                            (element) => element == user.user!.uid,
                            orElse: () => 'no existe');
                        if (estaRegistrado == user.user!.uid) {
                          context.push('/devices');
                        } else {
                          context.push('/register');
                        }
                      }
                    },
                    icon: Image.asset(
                      'assets/logo-google-G.png',
                      scale: 20,
                    ),
                    label: const Text('Continuar con Google')),
                //const SizedBox(height: 150),
                /* Image.asset(
                'assets/logo-google-G.png',
                scale: 10,
              ), */
                //TextButton(onPressed: () {}, child: const Text('CONTACTANOS'))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(400),
                    topLeft: Radius.circular(400))),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'CONTÁCTANOS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/icons/icon_whatsapp.png',
                          scale: 14, color: Colors.white),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/icons/icon_instagram.png',
                          scale: 14, color: Colors.white),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/icons/icon_youtube.png',
                          scale: 14, color: Colors.white),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/icons/icon_internet.png',
                          scale: 14, color: Colors.white),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                  ],
                ),
              ],
            )),

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
