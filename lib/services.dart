import 'package:flutter_application_1/dato.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final servicesProvider = Provider((ref) => Services());

class Services {
  late Future<Isar> db;

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
    isar.writeTxnSync(() => isar.datos.putSync(newDato));
  }
}
