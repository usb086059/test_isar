import 'package:isar/isar.dart';

part 'dato.g.dart';

@Collection()
class Dato {
  Id id = Isar.autoIncrement;

  late String name;
  int click;

  Dato({required this.name, this.click = 0});
}
