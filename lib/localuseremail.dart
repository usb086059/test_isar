import 'package:isar/isar.dart';

part 'localuseremail.g.dart';

@Collection()
class LocalUserEmail {
  Id id = Isar.autoIncrement;

  late String localUserEmail;

  LocalUserEmail({required this.localUserEmail});
}
