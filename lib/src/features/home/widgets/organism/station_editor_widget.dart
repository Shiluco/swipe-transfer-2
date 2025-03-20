import 'package:flutter/material.dart';
import 'package:swipe_transfer_2/src/models/station.dart';

class StationEditorWidget extends StatelessWidget {
  final int index;
  final Station station;
  final void Function(String) onNameChanged;
  final VoidCallback onRemove;

  const StationEditorWidget({
    required this.index,
    required this.station,
    required this.onNameChanged,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          //todo:並び替え機能の復活
          // ReorderableDelayedDragStartListener(
          //   index: index,
          //   child: const Icon(Icons.drag_indicator),
          // ),
          const SizedBox(width: 8),
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
