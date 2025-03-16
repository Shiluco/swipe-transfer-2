import 'package:flutter/material.dart';
import 'package:swipe_transfer_2/src/providers/stations_provider.dart';

class StationEditorWidget extends StatelessWidget {
  final int index;
  final Station station;
  final void Function(String) onNameChanged;
  final VoidCallback onRemove;

  const StationEditorWidget({
    super.key,
    required this.index,
    required this.station,
    required this.onNameChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(station.id),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: station.name,
              decoration: InputDecoration(labelText: '駅名 ${index + 1}'),
              onChanged: onNameChanged,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
