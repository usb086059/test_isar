import 'package:flutter_application_1/dato.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final servicesProvider = Provider((ref) => Services());

class Services {
  late Future<Isar> db;
  int counter = 0;

  Services() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([DatoSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> addDato(Dato newDato) async {
    final isar = await db;
    return isar.writeTxnSync(() => isar.datos.putSync(newDato));
  }

  Future<void> deleteDato(int idDato) async {
    final isar = await db;
    return isar.writeTxn(() => isar.datos.delete(idDato));
  }

  Future<List<Dato>> getAll() async {
    final isar = await db;
    return await isar.datos.where().findAll();
  }

  Future<void> editDato(Dato dato) async {
    final isar = await db;
    await isar.writeTxn(() async {
      dato.name = 'hola';
      isar.datos.put(dato);
      return;
    });
  }

  Future<void> editClick(Dato dato) async {
    final isar = await db;

    await isar.writeTxn(() async {
      (dato.click == 0) ? dato.click = 1 : dato.click = 0;
      isar.datos.put(dato);
    });
    Dato? clickSelected = await isar.datos
        .filter()
        .clickEqualTo(1)
        .not()
        .idEqualTo(dato.id)
        .findFirst();
    clickSelected ??= dato;
    await isar.writeTxn(() async {
      if (clickSelected!.click != 0 && clickSelected.id != dato.id) {
        clickSelected.click = 0;
        isar.datos.put(clickSelected);
      }
    });
    return;
  }
}
