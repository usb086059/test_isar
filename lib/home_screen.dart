import 'package:flutter/material.dart';
import 'package:flutter_application_1/dato.dart';
import 'package:flutter_application_1/future_provider.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counter = ref.watch(counterProvider);
    final datoFuture = ref.watch(datoProvider);
    final Dato newDato = Dato(name: 'newDato', click: 0);
    List<Dato> listDatos = [];
    Dato datoToSend;
    List colores = [Colors.white, Colors.blue];
    //int indexColors = 0;
    //int click = ref.watch(colorsProvider);
    bool? check = ref.watch(chechProvider);
    //Future<List<Dato>> listDato = [];
    //listDato = ref.watch(servicesProvider).getAll();
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                ref.watch(servicesProvider).deleteDato(4);
                listDatos = await ref.watch(servicesProvider).getAll();
                ref.invalidate(datoProvider);
              },
              child: const Text('DELETE')),
          Text('$counter'),
          TextButton(
              onPressed: () async {
                ref.read(counterProvider.notifier).state++;
                //ref.watch(servicesProvider).addDato(Dato(name: 'Logro'));
                ref.watch(servicesProvider).addDato(newDato);
                listDatos = await ref.watch(servicesProvider).getAll();
                ref.invalidate(datoProvider);
              },
              child: const Text('ADD')),
          TextButton(
              onPressed: () async {
                listDatos = await ref.watch(servicesProvider).getAll();
                ref.invalidate(datoProvider);
              },
              child: const Text('GET ALL')),
          //Text('${listDatos.length}'),
          datoFuture.when(
              data: (listDatos) => ListView.builder(
                  reverse: false, // Organiza la lista acendente/decendente
                  primary: false,
                  shrinkWrap: true,
                  itemCount: listDatos.length,
                  itemBuilder: (context, index) {
                    final idDato = listDatos[index];
                    return ListTile(
                      tileColor: colores[idDato.click],
                      //splashColor: Colors.blue,
                      onTap: () async {
                        ref.read(counterProvider.notifier).state++;
                        datoToSend = idDato;
                        ref
                            .read(servicesProvider)
                            .editClick(idDato)
                            .then((_) => ref.invalidate(datoProvider));
                        //ref.watch(servicesProvider).editClick(idDato);
                        //ref.read(servicesProvider).editClick(idDato);
                        //listDatos = await ref.watch(servicesProvider).getAll();
                        //listDatos = await ref.watch(servicesProvider).getAll();
                        //ref.invalidate(datoProvider);
                      },
                      leading: Text('${idDato.id}'),
                      title: Row(
                        children: [
                          Text(idDato.name),
                          Checkbox(
                              activeColor: Colors.amber,
                              value: check,
                              onChanged: (bool? newCheck) async {
                                ref.read(chechProvider.notifier).state =
                                    newCheck;
                                ref.read(counterProvider.notifier).state++;
                                // ref.watch(servicesProvider).editClick(idDato);
                                // listDatos[index].click == 1
                                //     ? ref.read(chechProvider.notifier).state =
                                //         true
                                //     : ref.read(chechProvider.notifier).state =
                                //         false;
                                ref.invalidate(datoProvider);
                              })
                        ],
                      ),
                      subtitle: IconButton(
                          onPressed: () async {
                            ref.watch(servicesProvider).editDato(idDato);
                            listDatos =
                                await ref.watch(servicesProvider).getAll();
                            ref.invalidate(datoProvider);
                          },
                          icon: const Icon(Icons.edit)),
                      trailing: IconButton(
                          onPressed: () async {
                            ref.watch(servicesProvider).deleteDato(idDato.id);
                            listDatos =
                                await ref.watch(servicesProvider).getAll();
                            ref.invalidate(datoProvider);
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  }),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const Text('Cargando')),
        ],
      ),
    )));
  }
}
