import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/navigation_bar_redes.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    UserCredential? user;
/*     double anchoMin = MediaQuery.of(context).size.width * 0.35;
    double anchoMax = MediaQuery.of(context).size.width * 0.95;
    double altoMin = MediaQuery.of(context).size.height * 0.35;
    double altoMax = MediaQuery.of(context).size.height * 0.5; */
    List<Device> listDeviceConected = [];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        print('************* didPop es $didPop **************');
        if (didPop) {
          //context.go('/'); //return;
        } else {
          print('************* didPop es $didPop **************');
          //context.go('/');
        }
      },
      child: MaterialApp(
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
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
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
                          const SizedBox(height: 100),
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: heightScreen * 0.1,
                                minHeight: heightScreen * 0.1,
                                minWidth: widthScreen * 0.95,
                                maxWidth: widthScreen * 0.95),
                            child: Image.asset(
                              'assets/8.png',
                              //color: Colors.white,
                              scale: 20,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxHeight: heightScreen * 0.14,
                                minHeight: heightScreen * 0.14,
                                minWidth: widthScreen * 0.95,
                                maxWidth: widthScreen * 0.95),
                            child: Image.asset(
                              'assets/10.png',
                              scale: 18,
                            ),
                          ),
                          const SizedBox(height: 90),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 5, bottom: 18),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/icons/icono9.png'))),
                            child: FilledButton.tonalIcon(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () async {
                                  print(
                                      '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Usuario es: ${FirebaseAuth.instance.currentUser}');
                                  print(
                                      '+++++++++++++++++++++++++++++++++++++++ Usuario es: ${user}');
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: const Color.fromARGB(
                                              255, 50, 102, 175),
                                          backgroundColor: Colors.purple[300],
                                        ));
                                      });
                                  if (FirebaseAuth.instance.currentUser ==
                                      null) {
                                    user = await signInWithGoogle();

                                    print(
                                        '************************************** Usuario es: $user');
                                    if (user?.user != null) {
                                      final List googleID = await getGoogleID();
                                      final String estaRegistrado =
                                          await googleID.firstWhere(
                                              (element) =>
                                                  element == user?.user!.uid,
                                              orElse: () => 'no existe');
                                      if (context.mounted) {
                                        context.pop();
                                        if (ref.read(primerArranqueProvider) ==
                                            false) {
                                          listDeviceConected = await ref
                                              .read(servicesProvider)
                                              .getAllDeviceConected();
                                          if (listDeviceConected.isNotEmpty) {
                                            for (var element
                                                in listDeviceConected) {
                                              element.conectado = false;
                                              element.relojAsignado = 0;
                                              await ref
                                                  .read(servicesProvider)
                                                  .editDevice(element);
                                            }
                                          }
                                        }
                                        if (estaRegistrado == user?.user!.uid) {
                                          ref
                                              .read(primerArranqueProvider
                                                  .notifier)
                                              .update((state) => true);
                                          if (ref.read(cerroSesion)) {
                                            context.pop();
                                          } else {
                                            context.push('/bluetooth');
                                          }
                                        } else {
                                          ref
                                              .read(primerArranqueProvider
                                                  .notifier)
                                              .update((state) => true);
                                          context.push('/register');
                                        }
                                      }
                                    } else {
                                      if (context.mounted) {
                                        showDialogAviso(
                                            context, heightScreen, widthScreen);
                                        print(
                                            '*********************************** Detecto nulo');
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        if (context.mounted) {
                                          context.pop();
                                        }
                                      }
                                      if (context.mounted) {
                                        context.pop();
                                      }
                                    }
                                  } else {
                                    if (context.mounted) {
                                      context.pop();
                                      if (ref.read(primerArranqueProvider) ==
                                          false) {
                                        listDeviceConected = await ref
                                            .read(servicesProvider)
                                            .getAllDeviceConected();
                                        if (listDeviceConected.isNotEmpty) {
                                          for (var element
                                              in listDeviceConected) {
                                            element.conectado = false;
                                            element.relojAsignado = 0;
                                            await ref
                                                .read(servicesProvider)
                                                .editDevice(element);
                                          }
                                        }
                                      }
                                      ref
                                          .read(primerArranqueProvider.notifier)
                                          .update((state) => true);
                                      if (ref.read(cerroSesion)) {
                                        if (context.mounted) {
                                          context.pop();
                                        }
                                      } else {
                                        if (context.mounted) {
                                          context.push('/bluetooth');
                                        }
                                      }
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
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: const NavigationBarRedes()),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDialogAviso(
      BuildContext context, double heightScreen, double widthScreen) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.214,
                        maxWidth: widthScreen * 0.783),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.214,
                        maxWidth: widthScreen * 0.783),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(30),
                        gradient: gradientAlertDialog()),
                    child: Container(),
                  ),
                ),
              ),
              const AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Text(
                  'Error de conexión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      //fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Revise su conexión a internet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          );
        });
  }
}
