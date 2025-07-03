import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/pack_comando.dart';
import 'package:flutter_application_1/terapia_total.dart';

Map<String, dynamic> serializeDevice(Device dev) {
  Map<String, dynamic> device = {
    'tipo': dev.tipo,
    'mac': dev.mac,
    'nombre': dev.nombre,
    'conectado': dev.conectado,
    'relojAsignado': dev.relojAsignado
  };
  return device;
}

Device deSerializeDevice(Map<String, dynamic> dev) {
  Device device = Device(
      tipo: dev['tipo'],
      mac: dev['mac'],
      nombre: dev['nombre'],
      conectado: dev['conectado'],
      relojAsignado: dev['relojAsignado']);
  return device;
}

List<Map<String, dynamic>> serializeListDevice(List<Device> listDev) {
  List<Map<String, dynamic>> listDevice = [];
  if (listDev.isNotEmpty) {
    for (Device element in listDev) {
      Map<String, dynamic> device = serializeDevice(element);
      listDevice.add(device);
    }
  }
  return listDevice;
}

List<Device> deSerializeListDevice(List<Map<String, dynamic>> listDev) {
  List<Device> listDevice = [];
  if (listDev.isNotEmpty) {
    for (Map<String, dynamic> element in listDev) {
      Device device = deSerializeDevice(element);
      listDevice.add(device);
    }
  }
  return listDevice;
}

Map<String, dynamic> serializePackComando(PackComando pack) {
  Map<String, dynamic> terapia = serializeTerapiaTotal(pack.terapia);
  Map<String, dynamic> packCommando = {
    'deviceMac': pack.deviceMac,
    'comando': pack.comando,
    'terapia': terapia,
    'enviado': pack.enviado
  };
  return packCommando;
}

PackComando deSerializePackComando(Map<String, dynamic> pack) {
  TerapiaTotal terapia = deSerializeTerapiaTotal(pack['terapia']);
  PackComando packComando = PackComando(
      deviceMac: pack['deviceMac'],
      comando: pack['comando'],
      terapia: terapia,
      enviado: pack['enviado']);
  return packComando;
}

Map<String, dynamic> serializeTerapiaTotal(TerapiaTotal terapia) {
  Map<String, dynamic> terapiaTotal = {
    'nombre': terapia.nombre,
    'frecMin': terapia.frecMin,
    'frecMax': terapia.frecMax,
    'info': terapia.info,
    'editable': terapia.editable,
    'idTerapiaPersonal': terapia.idTerapiaPersonal,
  };
  return terapiaTotal;
}

TerapiaTotal deSerializeTerapiaTotal(Map<String, dynamic> terapia) {
  TerapiaTotal terapiaTotal = TerapiaTotal(
      nombre: terapia['nombre'],
      frecMin: terapia['frecMin'],
      frecMax: terapia['frecMax'],
      info: terapia['info'],
      editable: terapia['editable'],
      idTerapiaPersonal: terapia['idTerapiaPersonal']);
  return terapiaTotal;
}
