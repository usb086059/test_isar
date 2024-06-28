import 'package:isar/isar.dart';

part 'terapia.g.dart';

@Collection()
class Terapia {
  Id id = Isar.autoIncrement;

  late String nombre;
  int frecMin;
  int frecMax;

  Terapia({required this.nombre, this.frecMin = 0, this.frecMax = 0});
}
