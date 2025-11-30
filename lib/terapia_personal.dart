import 'package:isar_community/isar.dart';

part 'terapia_personal.g.dart';

@Collection()
class TerapiaPersonal {
  Id id = Isar.autoIncrement;

  int frecMin;
  int frecMax;
  late String nombre;
  late String info;
  bool editable;

  TerapiaPersonal(
      {required this.nombre,
      required this.frecMin,
      required this.frecMax,
      required this.info,
      required this.editable});
}

/*
  Cada vez que modifique la collection debo ejecutar en la terminal el comando:
  flutter pub run build_runner build
*/
