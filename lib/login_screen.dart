import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
/*     double anchoMin = MediaQuery.of(context).size.width * 0.35;
    double anchoMax = MediaQuery.of(context).size.width * 0.95;
    double altoMin = MediaQuery.of(context).size.height * 0.35;
    double altoMax = MediaQuery.of(context).size.height * 0.5; */
    /* final Uri urlWhatsapp = Uri.parse('https://wa.me/584241283205');
    final Uri urlInstagram = Uri.parse('https://www.instagram.com/grupoavt/');
    final Uri urlFacebook =
        Uri.parse('https://www.facebook.com/profile.php?id=100083266544719');
    final Uri urlYoutube = Uri.parse('https://grupoavt.com');
    final Uri urlWeb = Uri.parse('https://grupoavt.com');
    final List listContactos = []; */
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: fondoLoginScreenGradient()),
          ),
          ClipPath(
            clipper: LoginCurve(),
            child: Container(
              decoration: BoxDecoration(gradient: purpleGradientCurvas()),
              //height: 100,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              height: heightScreen,
              width: widthScreen,
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/logoEnNegro1080.png',
                        scale: 3.5,
                      ),
                      //const SizedBox(height: 50),
                      /* Card(
                          color: Colors.blue,
                          child: Image.asset(
                              'assets/avt-logo-vectorizado-en-dorado-y-blanco-02-1-600x178.png'),
                        ),
                        */
                      const SizedBox(height: 100),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: heightScreen * 0.1,
                            minHeight: heightScreen * 0.1,
                            minWidth: widthScreen * 0.95,
                            maxWidth: widthScreen * 0.95),
                        //color: Colors.amber[50],
                        child: Image.asset(
                          'assets/8.png',
                          //color: Colors.white,
                          scale: 20,
                        ),
                      ),
                      //const SizedBox(height: 1),
                      Container(
                        //color: Colors.white,
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxHeight: heightScreen * 0.14,
                            minHeight: heightScreen * 0.14,
                            minWidth: widthScreen * 0.95,
                            maxWidth: widthScreen * 0.95),
                        //color: Colors.amber[50],
                        child: Image.asset(
                          'assets/10.png',
                          //color: Colors.white,
                          scale: 18,
                        ),
                      ),
                      const SizedBox(height: 90),
                      /* Text('Ancho Minimo = $anchoMin ... Ancho Maximo = $anchoMax'),
                        Text('Alto Minimo = $altoMin ... Alto Maximo = $altoMax'),
                        Text(
                            'HeightScreen = $heightScreen ... WidthScreen = $widthScreen'), */

                      /* const Padding(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                          child: Text(
                            'Inicie sesión con una cuenta de Google',
                            style: TextStyle(
                                fontSize: 15,
                                //color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ), */
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 18),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/icons/icono9.png'))),
                        child: FilledButton.tonalIcon(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent)),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: const Color.fromARGB(
                                          255, 50, 102, 175),
                                      backgroundColor: Colors.purple[300],
                                    ));
                                  });
                              final user = await signInWithGoogle();
                              if (user.user != null) {
                                final List googleID = await getGoogleID();
                                final String estaRegistrado =
                                    googleID.firstWhere(
                                        (element) => element == user.user!.uid,
                                        orElse: () => 'no existe');
                                context.pop();
                                if (estaRegistrado == user.user!.uid) {
                                  context.push('/devices');
                                } else {
                                  context.push('/register');
                                }
                              }
                            },
                            icon: Image.asset('assets/logo-google-G.png',
                                scale: 20),
                            label: const Text(
                              'Inicie sesión con Google',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 50, 102, 175),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      //const SizedBox(height: 10),
                      /* FilledButton.tonalIcon(
                            style: const ButtonStyle(
                                textStyle:
                                    MaterialStatePropertyAll(TextStyle(fontSize: 20)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 219, 239, 255)),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () async {
                              final user = await signInWithGoogle(context);
                              print('${user.user!.displayName}');
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
                            label: const Text('Continuar con Google')), */
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
            ),
            bottomNavigationBar: SizedBox(
                height: 100,
                /* decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))), */
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    /* const Text(
                        'CONTÁCTANOS',
                        style: TextStyle(
                            //color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ), */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final String whatsapp =
                                await getContacto('whatsapp');
                            myLaunchUrl(whatsapp);
                          },
                          icon: Image.asset(
                            'assets/icons/icono10.png',
                            //Image.asset('assets/icons/icon_whatsapp.png',
                            scale: 10,
                            //color: Colors.blue
                          ),
                          color: Colors.red,
                          iconSize: 40,
                        ),
                        /* IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/icons/whatsappColor.png',
                              //Image.asset('assets/icons/icon_whatsapp.png',
                              scale: 14,
                              //color: Colors.blue
                            ),
                            color: Colors.blue,
                            iconSize: 40,
                          ), */
                        IconButton(
                          onPressed: () async {
                            final String instagram =
                                await getContacto('instagram');
                            myLaunchUrl(instagram);
                          },
                          icon: Image.asset(
                            'assets/icons/icono11.png',
                            //Image.asset('assets/icons/icon_instagram.png',
                            scale: 10,
                            //color: Colors.blue
                          ),
                          color: Colors.blue,
                          iconSize: 40,
                        ),
                        IconButton(
                          onPressed: () async {
                            final String facebook =
                                await getContacto('facebook');
                            myLaunchUrl(facebook);
                          },
                          icon: Image.asset('assets/icons/icono12.png',
                              scale: 10),
                          //const Icon(Icons.facebook),
                          color: Colors.blue,
                          iconSize: 40,
                        ),
                        IconButton(
                          onPressed: () async {
                            final String youtube = await getContacto('youtube');
                            myLaunchUrl(youtube);
                          },
                          icon: Image.asset(
                            'assets/icons/icono13.png',
                            //Image.asset('assets/icons/icon_youtube.png',
                            scale: 10,
                            //color: Colors.blue
                          ),
                          color: Colors.blue,
                          iconSize: 40,
                        ),
                        IconButton(
                          onPressed: () async {
                            final String web = await getContacto('web');
                            myLaunchUrl(web);
                          },
                          icon: Image.asset('assets/icons/icono14.png',
                              scale: 10),
                          color: Colors.blue,
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
        ],
      ),
    );
  }

  Future<void> myLaunchUrl(String urlContacto) async {
    final Uri url = Uri.parse(urlContacto);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('No se encontró el URL $url');
    }
  }
}
