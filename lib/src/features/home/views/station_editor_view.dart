import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/providers/stations_provider.dart';
import 'package:swipe_transfer_2/src/models/station.dart';
import 'package:swipe_transfer_2/src/features/home/widgets/organism/station_editor_widget.dart';
import 'package:go_router/go_router.dart';

class StationEditorView extends ConsumerWidget {
  const StationEditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stations = ref.watch(stationsProvider);
    final stationNotifier = ref.read(stationsProvider.notifier);

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
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) newIndex -= 1;
                final item = stations[oldIndex];
                stationNotifier.removeStation(item.id); // 古い位置から削除
                stationNotifier.addStation(item); // 新しい位置に追加
              },
              itemBuilder: (context, index) {
                final station = stations[index];
                return StationEditorWidget(
                  key: ValueKey(station.id),
                  index: index,
                  station: station,
                  onNameChanged: (value) {
                    stationNotifier.updateStation(
                      Station(id: station.id, name: value),
                    );
                  },
                  onRemove: () {
                    stationNotifier.removeStation(station.id);
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  final newId = stations.isNotEmpty ? stations.last.id + 1 : 1;
                  stationNotifier.addStation(Station(id: newId, name: ''));
                },
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
