import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/future_provider.dart';
import 'package:flutter_application_1/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeZapperScreen extends ConsumerWidget {
  const HomeZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
              padding: const EdgeInsets.all(4),
              child:
                  CircleAvatar(backgroundImage: NetworkImage(user!.photoURL!))),
          centerTitle: true,
          title: const Text(
            'ZAPPER',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 1])),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
            child: Column(
              children: [
                const Text('MODOS DE APLICACIÓN',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: heightScreen * 0.35,
                      maxWidth: widthScreen * 0.95),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(99, 132, 194, 252),
                            blurRadius: 180,
                            blurStyle: BlurStyle.inner,
                            spreadRadius: 5)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: FittedBox(
                              //alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                elevation: 20,
                                //color: Colors.blue,
                                shadowColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Text('POR TANDAS',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      DataTable(
                                          headingTextStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          dataTextStyle:
                                              const TextStyle(fontSize: 20),
                                          columnSpacing: 17,
                                          columns: const [
                                            DataColumn(
                                                label: Text(
                                                  'CICLOS',
                                                ),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('ON  '),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('OFF  '),
                                                numeric: true),
                                          ],
                                          rows: const [
                                            DataRow(cells: [
                                              DataCell(Text('1     ')),
                                              DataCell(Text('7 min')),
                                              DataCell(Text('20 min')),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(Text('2     ')),
                                              DataCell(Text('7 min')),
                                              DataCell(Text('20 min')),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(Text('3     ')),
                                              DataCell(Text('7 min')),
                                              DataCell(Text('FIN  ')),
                                            ])
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                elevation: 20,
                                //color: Colors.blue,
                                shadowColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Text('CONTINUO',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      DataTable(
                                          headingTextStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          dataTextStyle:
                                              const TextStyle(fontSize: 20),
                                          columnSpacing: 17,
                                          columns: const [
                                            DataColumn(
                                                label: Text('CICLOS'),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('ON   '),
                                                numeric: true),
                                            DataColumn(
                                                label: Text('OFF'),
                                                numeric: true),
                                          ],
                                          rows: const [
                                            DataRow(cells: [
                                              DataCell(Text('1     ')),
                                              DataCell(Text('60 min')),
                                              DataCell(Text('FIN')),
                                            ]),
                                            /* DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('7')),
                                          DataCell(Text('20')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('7')),
                                          DataCell(Text('20')),
                                        ]) */
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'TERAPIAS',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.edit_note)),
                    //SizedBox(width: 4),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_forever)),
                    //SizedBox(width: 4),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  ],
                ),
                //const SizedBox(height: 4),
                Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.47,
                        maxWidth: widthScreen * 0.95),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(99, 132, 194, 252),
                              blurRadius: 180,
                              blurStyle: BlurStyle.inner,
                              spreadRadius: 5)
                        ]),
                    child: FutureBuilder(
                        future: getTerapias(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: GridView.builder(
                                  itemCount: snapshot.data?.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio:
                                              heightScreen * 0.0023,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return CustomTherapy(
                                        name: snapshot.data?[index]['nombre'],
                                        frecMin: snapshot.data?[index]
                                            ['frecMin'],
                                        frecMax: snapshot.data?[index]
                                            ['frecMax']);
                                  }),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))

                    /* FutureBuilder(
                        future: getTerapias(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                      snapshot.data?[index]['nombre']);
                                });
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })) */

                    /* GridView.builder(
                      itemCount: 3,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 10,
                            width: 10,
                            color: Colors.blue,
                          ),
                        );
                      }), */

                    /* GridView.count(
                    childAspectRatio: heightScreen * 0.0023,
                    scrollDirection: Axis.vertical,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: const <Widget>[
                      // Container(
                      //   //height: 10,
                      //   //width: 100,
                      //   color: Colors.blue,
                      // ),
                
                      CustomTherapy(
                          name: "Problemas Intestinales",
                          frecMin: 100,
                          frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia Dos", frecMin: 100, frecMax: 200),
                      CustomTherapy(
                          name: "Frecuencia 30", frecMin: 100, frecMax: 200),
                    ],
                  ), */
                    )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //elevation: 3,
          tooltip: 'Siguiente',
          shape: const StadiumBorder(),
          backgroundColor: Colors.blue,

          onPressed: () {
            context.push('/timerZapper');
          },
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.blue, Colors.white],
                  stops: [0.01, 0.8])),
          child: BottomAppBar(
            height: heightScreen * 0.05,
            color: Colors.transparent,
            notchMargin: 4,
            shape: const CircularNotchedRectangle(),
          ),
        ),
      ),
    );
  }
}

class CustomTherapy extends StatelessWidget {
  final String name;
  final int frecMin;
  final int frecMax;

  const CustomTherapy({
    Key? key,
    required this.name,
    required this.frecMin,
    required this.frecMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(4.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 20,
        //color: Colors.blue,
        shadowColor: Colors.blue,
        child: Container(
          alignment: Alignment.center,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),

            splashColor: Colors.blue,
            onTap: () {},
            //leading: const Icon(Icons.arrow_forward_ios),
            // trailing: const Icon(
            //   Icons.favorite,
            //   size: 10,
            // ),
            title: Text(
              name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '$frecMin KHz - $frecMax KHz',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
