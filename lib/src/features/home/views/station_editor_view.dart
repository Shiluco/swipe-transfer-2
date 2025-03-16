import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/providers/stations_provider.dart';
import 'package:swipe_transfer_2/src/features/home/widgets/organism/station_editor_widget.dart';
import 'package:go_router/go_router.dart';

class StationEditorView extends ConsumerWidget {
  const StationEditorView({super.key});

  void _addStation(WidgetRef ref) {
    final stations = ref.read(stationsProvider);
    final newId = stations.isNotEmpty ? stations.last.id + 1 : 1;
    ref.read(stationsProvider.notifier).state = [
      ...stations,
      Station(id: newId, name: ''),
    ];
  }

  void _removeStation(WidgetRef ref, int index) {
    final stations = List<Station>.from(ref.read(stationsProvider));
    stations.removeAt(index);
    ref.read(stationsProvider.notifier).state = stations;
  }

  void _updateStationName(WidgetRef ref, int index, String name) {
    final stations = List<Station>.from(ref.read(stationsProvider));
    stations[index] = Station(id: stations[index].id, name: name);
    ref.read(stationsProvider.notifier).state = stations;
  }

  void _handleReorder(WidgetRef ref, int oldIndex, int newIndex) {
    final stations = List<Station>.from(ref.read(stationsProvider));
    if (oldIndex < newIndex) newIndex -= 1;
    final item = stations.removeAt(oldIndex);
    stations.insert(newIndex, item);
    ref.read(stationsProvider.notifier).state = stations;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stations = ref.watch(stationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('駅編集'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: stations.length,
              onReorder:
                  (oldIndex, newIndex) =>
                      _handleReorder(ref, oldIndex, newIndex),
              itemBuilder: (context, index) {
                final station = stations[index];
                return StationEditorWidget(
                  key: ValueKey(station.id), // StationEditorWidgetに直接keyを渡す
                  index: index,
                  station: station,
                  onNameChanged:
                      (value) => _updateStationName(ref, index, value),
                  onRemove: () => _removeStation(ref, index),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _addStation(ref),
                child: const Text('+'),
              ),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
