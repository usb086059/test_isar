import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationBarRedes extends StatelessWidget {
  const NavigationBarRedes({super.key});

  @override
  Widget build(BuildContext context) {
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
                    final String whatsapp = await getContacto('whatsapp');
                    myLaunchUrl(whatsapp);
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
                    final String instagram = await getContacto('instagram');
                    myLaunchUrl(instagram);
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
                    final String facebook = await getContacto('facebook');
                    myLaunchUrl(facebook);
                  },
                  icon: Image.asset('assets/icons/icono12.png', scale: 10),
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
                    scale: 10,
                  ),
                  color: Colors.blue,
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () async {
                    final String web = await getContacto('web');
                    myLaunchUrl(web);
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

  Future<void> myLaunchUrl(String urlContacto) async {
    final Uri url = Uri.parse(urlContacto);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('No se encontró el URL $url');
    }
  }
}
