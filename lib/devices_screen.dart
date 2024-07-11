import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    final String nameUser = user!.displayName!;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(backgroundImage: NetworkImage(user.photoURL!)),
          ),
          centerTitle: false,
          title: Text(
            nameUser,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          constraints: BoxConstraints(maxWidth: widthScreen),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/dedo_touch.png', scale: 3),
                  const SizedBox(height: 10),
                  const FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Text('ELIJA EL DISPOSITIVO',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue,
                      shadowColor: Colors.black,
                      elevation: 40,
                      child: ListTile(
                        onTap: () {},
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_circulo.png',
                                scale: 40),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('PEDILUVIO',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue,
                      shadowColor: Colors.black,
                      elevation: 40,
                      child: ListTile(
                        onTap: () {},
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_circulo.png',
                                scale: 40),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('PEDILUVIO CON ZAPPER',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue,
                      shadowColor: Colors.black,
                      elevation: 40,
                      child: ListTile(
                        onTap: () {
                          context.push('/homeZapper');
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_circulo.png',
                                scale: 40),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ZAPPER',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue,
                      shadowColor: Colors.black,
                      elevation: 40,
                      child: ListTile(
                        onTap: () {},
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/icon_circulo.png',
                                scale: 40),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('DERMATRONIC',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
