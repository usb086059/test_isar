//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:ffi';

//import 'dart:math';
//import 'dart:ui_web';

import 'package:flutter_application_1/dato.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/terapia.dart';
import 'package:flutter_application_1/terapia_personal.dart';
import 'package:flutter_application_1/terapia_total.dart';
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
      return await Isar.open([
        DatoSchema,
        TerapiaSchema,
        TerapiaPersonalSchema,
        TerapiaTotalSchema,
        DeviceSchema
      ], directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> addAllTerapiasIniciales() async {
    final List listTerapiasIniciales =
        await getTerapias(); //Lista de terapias de Firebase
    for (var element in listTerapiasIniciales) {
      final Terapia terapia = Terapia(
          id: element['id'],
          nombre: element['nombre'],
          frecMin: element['frecMin'],
          frecMax: element['frecMax'],
          info: element['info'],
          editable: element['editable']);
      addTerapia(terapia); //Agregar a la lista de terapia local
    }
    return;
  }

  Future<void> terapiasIniciales() async {
    final isar = await db;
    final List<Terapia> listTerapias = await isar.terapias
        .where()
        .findAll(); //Lsita de terapias iniciales local
    final List listTerapiasIniciales =
        await getTerapias(); //Lista de terapias de Firebase

    if (listTerapiasIniciales.length == listTerapias.length) {
      for (int i = 0; i < listTerapiasIniciales.length; i++) {
        if (listTerapiasIniciales[i] != listTerapias[i]) {
          final Terapia terapia = Terapia(
              id: listTerapiasIniciales[i]['id'],
              nombre: listTerapiasIniciales[i]['nombre'],
              frecMin: listTerapiasIniciales[i]['frecMin'],
              frecMax: listTerapiasIniciales[i]['frecMax'],
              info: listTerapiasIniciales[i]['info'],
              editable: listTerapiasIniciales[i]['editable']);
          addTerapia(terapia);
        }
      }
    } else {
      isar.writeTxnSync(() => isar.terapias.clearSync());
      addAllTerapiasIniciales();
    }
    return;
  }

  Future<void> cargarTerapiaTotal() async {
    final isar = await db;
    final List listTerapias =
        await getAllTerapia(); //Lsita de terapias iniciales local
    final List listTerapiasPersonal =
        await getAllTerapiaPersonal(); //Lista de terapias personal local
    final List listTerapiasTotal =
        []; //Esta lista es la que se mostrara en el Gridview

    isar.writeTxnSync(() => isar.terapiaTotals.clearSync());

    for (var element in listTerapiasPersonal) {
      listTerapiasTotal.add(element);
    }

    for (var element in listTerapias) {
      listTerapiasTotal.add(element);
    }

    for (var element in listTerapiasTotal) {
      final TerapiaTotal terapiaTotal = TerapiaTotal(
          nombre: element.nombre,
          frecMin: element.frecMin,
          frecMax: element.frecMax,
          info: element.info,
          editable: element.editable,
          idTerapiaPersonal: element.id);
      addTerapiaTotal(terapiaTotal);
    }
    return;
  }

  Future<void> addTerapia(Terapia newTerapia) async {
    final isar = await db;
    return await isar.writeTxnSync(() => isar.terapias.putSync(newTerapia));
  }

  Future<void> addTerapiaTotal(TerapiaTotal newTerapia) async {
    final isar = await db;
    return await isar
        .writeTxnSync(() => isar.terapiaTotals.putSync(newTerapia));
  }

  Future<void> addTerapiaPersonal(TerapiaPersonal newTerapia) async {
    final isar = await db;
    return await isar
        .writeTxnSync(() => isar.terapiaPersonals.putSync(newTerapia));
  }

  Future<void> addDato(Dato newDato) async {
    final isar = await db;
    return isar.writeTxnSync(() => isar.datos.putSync(newDato));
  }

  Future<void> deleteDato(int idDato) async {
    final isar = await db;
    return isar.writeTxn(() => isar.datos.delete(idDato));
  }

  Future<void> deleteTerapiaPersonal(int id) async {
    final isar = await db;
    final bool delete =
        await isar.writeTxnSync(() => isar.terapiaPersonals.deleteSync(id));
    cargarTerapiaTotal();
    return;
  }

//*********DEVICE*********** */
  Future<void> addDevice(Device newDevice) async {
    final isar = await db;
    return isar.writeTxnSync(() => isar.devices.putSync(newDevice));
  }

  Future<void> editDevice(Device device) async {
    //final isar = await db;
    //final Device? deviceActual = await isar.devices.get(device.id);
    final Device deviceActual = await getDevice(device.mac);
    deviceActual.nombre = device.tipo;
    deviceActual.mac = device.mac;
    deviceActual.nombre = device.nombre;
    deviceActual.conectado = device.conectado;
    deviceActual.relojAsignado = device.relojAsignado;
    addDevice(deviceActual);
  }

  Future<void> deleteDevice(int idDevice) async {
    final isar = await db;
    return isar.writeTxn(() => isar.devices.delete(idDevice));
  }

  Future<bool> getDeviceExists(String mac) async {
    final isar = await db;
    final Device? device =
        await isar.devices.where().filter().macEqualTo(mac).findFirst();
    if (device?.id != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Device> getDevice(String mac) async {
    final isar = await db;
    final Device? device =
        await isar.devices.where().filter().macEqualTo(mac).findFirst();
    //print('*********444444444444444444444444 ${device!.conectado}');
    return device!;
  }

  Future<String> getDeviceNombre(String mac) async {
    final isar = await db;
    final Device? device =
        await isar.devices.where().filter().macEqualTo(mac).findFirst();
    return device!.nombre;
  }

  Future<List<Device>> getAllDevice() async {
    final isar = await db;
    final lista = await isar.devices.where().findAll();
    return lista;
  }

  Future<List<Device>> getAllDeviceConected() async {
    final isar = await db;
    final lista =
        await isar.devices.where().filter().conectadoEqualTo(true).findAll();
    return lista;
  }

  Future<List<Device>> getAllDeviceConRelojAsignado() async {
    final isar = await db;
    final lista = await isar.devices
        .where()
        .filter()
        .conectadoEqualTo(true)
        .and()
        .relojAsignadoGreaterThan(0)
        .findAll();
    return lista;
  }
  /* ----------------DEVICE -------------------- */

  Future<TerapiaTotal> getTerapiaSeleccionada(int id) async {
    //final isar = await db;
    final List listTerapiasTotal = await getAllTerapiaTotal();
    TerapiaTotal terapiaSeleccionada = listTerapiasTotal[id];
    //Terapia terapiaSeleccionada = isar.terapias.getSync(id)!;
    return terapiaSeleccionada;
  }

  Future<List<Terapia>> getAllTerapia() async {
    final isar = await db;
    final lista = await isar.terapias.where().findAll();
    return lista;
  }

  Future<List<TerapiaTotal>> getAllTerapiaTotal() async {
    final isar = await db;
    final terapiasTotales =
        await isar.terapiaTotals.where().sortByNombre().findAll();
    return terapiasTotales; //await isar.terapiaTotals.where().sortByNombre().findAll();
  }

  Future<List<TerapiaPersonal>> getAllTerapiaPersonal() async {
    final isar = await db;
    return await isar.terapiaPersonals.where().findAll();
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

  Future<void> editTerapiaPersonal(TerapiaTotal terapia) async {
    final isar = await db;
    final TerapiaPersonal? terapiaPersonalActual =
        await isar.terapiaPersonals.get(terapia.idTerapiaPersonal);
    terapiaPersonalActual!.nombre = terapia.nombre;
    terapiaPersonalActual.frecMin = terapia.frecMin;
    terapiaPersonalActual.frecMax = terapia.frecMax;
    terapiaPersonalActual.info = terapia.info;
    terapiaPersonalActual.editable = terapia.editable;
    addTerapiaPersonal(terapiaPersonalActual);
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
