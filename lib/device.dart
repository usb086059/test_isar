import 'package:isar/isar.dart';

part 'device.g.dart';

@Collection()
class Device {
  Id id = Isar.autoIncrement;

  late String tipo;
  late String mac;
  late String nombre;
  late bool conectado;
  late int relojAsignado;

  Device(
      {required this.tipo,
      required this.mac,
      required this.nombre,
      required this.conectado,
      required this.relojAsignado});
}

/*
  Cada vez que modifique la collection debo ejecutar en la terminal el comando:
  flutter pub run build_runner build
*/