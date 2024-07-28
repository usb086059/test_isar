import 'package:flutter/material.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurvaScreen extends ConsumerWidget {
  const CurvaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            //color: Colors.white,
            decoration: BoxDecoration(gradient: azulGradient()),
          ),
          ClipPath(
            clipper: LoginCurve(),
            child: Container(
              decoration: BoxDecoration(gradient: fondoLoginScreenGradient()),
              //height: 100,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              //color: Colors.blue.withOpacity(0.3),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  /* borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)) */
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              //color: Colors.red,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Image.asset(
                        'assets/avt-logo-9.png',
                        scale: 7,
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
                          color: Colors.white,
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
                          color: Colors.white,
                          scale: 18,
                        ),
                      ),
                      const SizedBox(height: 100),
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
                            onPressed: () {},
                            /* () async {
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
                        }, */
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
            /* bottomNavigationBar: Container(
              height: 100,
              color: Colors.blue,
            ), */

            /* Stack(
              children: [
                /* Container(
                  height: 100,
                  color: Colors.green,
                  //child: Text('data'),
                ),
                Container(
                  height: 50,
                  color: Colors.white,
                  //child: Text('data'),
                ), */
                ClipPath(
                  clipper: BazierCurve(),
                  child: Container(
                    decoration: BoxDecoration(gradient: purpleGradientCurvas()),
                    //height: 100,
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    //color: Colors.blue.withOpacity(0.3),
                  ),
                ),
              ],
            ), */
            bottomNavigationBar: Container(
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                          onPressed: () {},
                          icon: Image.asset('assets/icons/icono12.png',
                              scale: 10),
                          //const Icon(Icons.facebook),
                          color: Colors.blue,
                          iconSize: 40,
                        ),
                        IconButton(
                          onPressed: () {},
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
                          onPressed: () {},
                          icon: Image.asset('assets/icons/icono14.png',
                              scale: 10),
                          color: Colors.blue,
                          iconSize: 40,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class BazierCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.arcToPoint(
      Offset(size.width * 0.3, size.height * 0.103),
      radius: const Radius.circular(105),
      clockwise: false,
    );
    path.lineTo(size.width * 0.7, size.height * 0.103);
    path.arcToPoint(
      Offset(size.width, size.height * 0.206),
      radius: const Radius.circular(105),
      clockwise: true,
    );
    path.lineTo(size.width, size.height * 0.794);
    path.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.897),
      radius: const Radius.circular(105),
      clockwise: true,
    );
    path.lineTo(size.width * 0.2, size.height * 0.897);
    path.arcToPoint(
      Offset(0, size.height),
      radius: const Radius.circular(80),
      clockwise: false,
    );

/*     path.quadraticBezierTo(size.width * 0.1, size.height * 0.152,
        size.width * 0.5, size.height * 0.152);
    path.quadraticBezierTo(size.width * 0.75, size.height * -0.0,
        size.width * 0.97, size.height * 0.15); */
    //path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
