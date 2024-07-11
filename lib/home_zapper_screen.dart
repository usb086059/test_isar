import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/future_provider.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeZapperScreen extends ConsumerWidget {
  const HomeZapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(countdownProvider);
    final bool modoSeleccionado = ref.watch(selectModoProvider);
    final int terapiaSeleccionada = ref.watch(indexTerapiaProvider);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    ScrollController _scroll = ScrollController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
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
                //const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: heightScreen * 0.35,
                      maxWidth: widthScreen * 0.95),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FittedBox(
                            //alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(selectModoProvider.notifier).state =
                                    true;
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                elevation: 10,
                                color: modoSeleccionado
                                    ? Colors.blue
                                    : Colors.white,
                                shadowColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('POR TANDAS',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: modoSeleccionado
                                                  ? Colors.white
                                                  : null,
                                              fontWeight: FontWeight.bold)),
                                      DataTable(
                                          headingTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: modoSeleccionado
                                                  ? Colors.white
                                                  : null,
                                              fontWeight: FontWeight.bold),
                                          dataTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: modoSeleccionado
                                                  ? Colors.white
                                                  : null),
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
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(selectModoProvider.notifier).state =
                                    false;
                              },
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                elevation: 10,
                                color: modoSeleccionado
                                    ? Colors.white
                                    : Colors.blue,
                                shadowColor: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('CONTINUO',
                                          style: TextStyle(
                                              color: modoSeleccionado
                                                  ? null
                                                  : Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      DataTable(
                                          headingTextStyle: TextStyle(
                                              color: modoSeleccionado
                                                  ? null
                                                  : Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          dataTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: modoSeleccionado
                                                  ? null
                                                  : Colors.white),
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
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
                        maxHeight: heightScreen * 0.57,
                        maxWidth: widthScreen * 0.95),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: FutureBuilder(
                        future: getTerapias(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                                controller: _scroll,
                                itemCount: snapshot.data?.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: heightScreen * 0.0023,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 12,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  if (ref
                                      .watch(countdownProvider)
                                      .volvioDeTimerZapperScreen) {
                                    ref.watch(countdownProvider).volver(false);
                                    _scroll.jumpTo(
                                        _scroll.position.minScrollExtent);
                                  }
                                  return CustomTherapy(
                                    name: snapshot.data?[index]['nombre'],
                                    frecMin: snapshot.data?[index]['frecMin'],
                                    frecMax: snapshot.data?[index]['frecMax'],
                                    terapiaSel: index,
                                  );
                                });
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
            modoSeleccionado
                ? timer.startStopTimer('Modo A')
                : timer.startStopTimer('Modo B');
            context.push('/timerZapper');
          },
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class CustomTherapy extends ConsumerWidget {
  final String name;
  final int frecMin;
  final int frecMax;
  final int terapiaSel;

  const CustomTherapy(
      {Key? key,
      required this.name,
      required this.frecMin,
      required this.frecMax,
      required this.terapiaSel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final int ter = ref.watch(indexTerapiaProvider);
    return Card(
        color:
            ref.watch(indexTerapiaProvider) == terapiaSel ? Colors.blue : null,
        margin: const EdgeInsets.all(4.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 10,
        //color: Colors.blue,
        shadowColor: Colors.blue,
        child: Container(
          alignment: Alignment.center,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),

            //splashColor: Colors.blue,
            onTap: () {
              ref.read(indexTerapiaProvider.notifier).state = terapiaSel;
            },
            //leading: const Icon(Icons.arrow_forward_ios),
            // trailing: const Icon(
            //   Icons.favorite,
            //   size: 10,
            // ),
            title: Text(
              name,
              style: TextStyle(
                  color: ref.watch(indexTerapiaProvider) == terapiaSel
                      ? Colors.white
                      : null,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '$frecMin KHz - $frecMax KHz',
              style: TextStyle(
                  color: ref.watch(indexTerapiaProvider) == terapiaSel
                      ? Colors.white
                      : null,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
