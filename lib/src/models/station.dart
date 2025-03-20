import 'package:isar/isar.dart';

part 'station.g.dart';

@collection
class Station {
  Id id = Isar.autoIncrement;
  late int stationId;
  late String name;
}
