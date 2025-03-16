import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/features/home/widgets/organism/station_widget.dart';
import 'package:swipe_transfer_2/src/providers/stations_provider.dart';

class StationsWidget extends ConsumerWidget {
  const StationsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プロバイダーから駅リストを取得
    final stations = ref.watch(stationsProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          stations.map((station) {
            return StationWidget(id: station.id, name: station.name);
          }).toList(),
    );
  }
}
