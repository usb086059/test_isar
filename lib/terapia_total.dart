import 'package:isar_community/isar.dart';

part 'terapia_total.g.dart';

@Collection()
class TerapiaTotal {
  Id id = Isar.autoIncrement;

  int frecMin;
  int frecMax;
  late String nombre;
  late String info;
  bool editable;
  int idTerapiaPersonal;

  TerapiaTotal(
      {required this.nombre,
      required this.frecMin,
      required this.frecMax,
      required this.info,
      required this.editable,
      required this.idTerapiaPersonal});
}

/*
  Cada vez que modifique la collection debo ejecutar en la terminal el comando:
  flutter pub run build_runner build
*/
