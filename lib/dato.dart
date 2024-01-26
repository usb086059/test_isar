import 'package:isar/isar.dart';

part 'dato.g.dart';

@Collection()
class Dato {
  Id id = Isar.autoIncrement;

  late String name;

  Dato({required this.name});
}
