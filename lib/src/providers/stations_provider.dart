import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/models/station.dart';
import 'package:swipe_transfer_2/src/providers/isar_provider.dart';
import 'package:isar/isar.dart';

class StationNotifier extends StateNotifier<List<Station>> {
  final Ref ref;

  StationNotifier(this.ref) : super([]) {
    _loadStations();
  }

  Future<void> _loadStations() async {
    final isar = ref.read(isarProvider).value;
    if (isar != null) {
      final stations = await isar.stations.where().findAll();
      if (stations.isEmpty) {
        // 初期データを追加
        final defaultStations = [
          Station(id: 1, name: '新宿'),
          Station(id: 2, name: '東京'),
          Station(id: 3, name: '恵比寿'),
          Station(id: 4, name: '品川'),
          Station(id: 5, name: 'みなとみらい'),
        ];

        await isar.writeTxn(() async {
          for (var station in defaultStations) {
            station.id = await isar.stations.put(station);
          }
        });

        state = defaultStations;
      } else {
        state = stations;
      }
    }
  }

  Future<void> addStation(Station station) async {
    final isar = ref.read(isarProvider).value;
    if (isar != null) {
      await isar.writeTxn(() async {
        station.id = await isar.stations.put(station);
      });
      state = [...state, station];
    }
  }

  Future<void> removeStation(int id) async {
    final isar = ref.read(isarProvider).value;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.stations.delete(id);
      });
      state = state.where((station) => station.id != id).toList();
    }
  }

  Future<void> updateStation(Station updatedStation) async {
    final isar = ref.read(isarProvider).value;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.stations.put(updatedStation);
      });
      state =
          state
              .map(
                (station) =>
                    station.id == updatedStation.id ? updatedStation : station,
              )
              .toList();
    }
  }

  List<Station> getStations() => state;
}

final stationsProvider = StateNotifierProvider<StationNotifier, List<Station>>(
  (ref) => StationNotifier(ref),
);
