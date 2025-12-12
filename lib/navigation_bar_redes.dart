import 'package:flutter/material.dart';
import 'package:flutter_application_1/aviso_error_conexion.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationBarRedes extends StatelessWidget {
  const NavigationBarRedes({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
        height: 70,
        color: Colors.transparent,
        child: Column(
          children: [
            /* const SizedBox(
              height: 0,
            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    openShowDialog(context);
                    final String whatsapp = await getContacto('whatsapp');
                    if (context.mounted) {
                      await myLaunchUrl(
                          context, whatsapp, heightScreen, widthScreen);
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  icon: Image.asset(
                    'assets/icons/icono10.png',
                    scale: 10,
                  ),
                  color: Colors.red,
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () async {
                    openShowDialog(context);
                    final String instagram = await getContacto('instagram');
                    if (context.mounted) {
                      await myLaunchUrl(
                          context, instagram, heightScreen, widthScreen);
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  icon: Image.asset(
                    'assets/icons/icono11.png',
                    scale: 10,
                  ),
                  color: Colors.blue,
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () async {
                    openShowDialog(context);
                    final String facebook = await getContacto('facebook');
                    if (context.mounted) {
                      await myLaunchUrl(
                          context, facebook, heightScreen, widthScreen);
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  icon: Image.asset('assets/icons/icono12.png', scale: 10),
                  color: Colors.blue,
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () async {
                    openShowDialog(context);
                    final String youtube = await getContacto('youtube');
                    if (context.mounted) {
                      await myLaunchUrl(
                          context, youtube, heightScreen, widthScreen);
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  icon: Image.asset(
                    'assets/icons/icono13.png',
                    scale: 10,
                  ),
                  color: Colors.blue,
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () async {
                    openShowDialog(context);
                    final String web = await getContacto('web');
                    if (context.mounted) {
                      await myLaunchUrl(
                          context, web, heightScreen, widthScreen);
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  icon: Image.asset('assets/icons/icono14.png', scale: 10),
                  color: Colors.blue,
                  iconSize: 40,
                ),
              ],
            ),
          ],
        ));
  }

  Future<dynamic> openShowDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: const Color.fromARGB(255, 50, 102, 175),
            backgroundColor: Colors.purple[300],
          ));
        });
  }

  Future<void> myLaunchUrl(BuildContext context, String urlContacto,
      double heightScreen, double widthScreen) async {
    if (urlContacto != 'error') {
      final Uri url = Uri.parse(urlContacto);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('No se encontró el URL $url');
      }
    } else {
      if (context.mounted) {
        showDialogAviso(context, heightScreen, widthScreen);
        await Future.delayed(const Duration(seconds: 3));
        if (context.mounted) {
          context.pop();
        }
      }
    }
  }

  Future<dynamic> showDialogAviso(
      BuildContext context, double heightScreen, double widthScreen) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AvisoErrorConexion(
              title: 'Error de conexión',
              content: 'Revise su conexión a internet');
        });
  }
}
