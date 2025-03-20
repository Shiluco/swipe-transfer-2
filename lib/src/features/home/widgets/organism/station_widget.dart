import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// グローバルなドラッグ状態を管理
final ValueNotifier<bool> isDraggingNotifier = ValueNotifier<bool>(false);

class StationWidget extends StatelessWidget {
  final int id;
  final String name;
  const StationWidget({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20; // 大きめのフォントサイズ

    return ValueListenableBuilder<bool>(
      valueListenable: isDraggingNotifier,
      builder: (context, isDragging, child) {
        return DragTarget<int>(
          onAcceptWithDetails: (details) {
            int draggedId = details.data; // ドラッグされたID
            print('🚀 ドラッグ: $draggedId → ドロップ: $id ');
          },
          builder: (context, candidateData, rejectedData) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 60, left: 25, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Draggable<int>(
                    data: id, // 駅のIDを渡す
                    feedback: Material(
                      color: Colors.transparent, // 背景を透明に
                      child: SvgPicture.asset(
                        'assets/images/fly.svg', // ドラッグ中のアイコン
                        width: fontSize + 15,
                        height: fontSize + 15,
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.0, // 元のアイコンを薄くする
                      child: SvgPicture.asset(
                        'assets/images/stay.svg',
                        width: fontSize + 15,
                        height: fontSize + 15,
                      ),
                    ),
                    child: SvgPicture.asset(
                      isDragging
                          ? 'assets/images/gole.svg' // ドラッグ中はgole.svg
                          : 'assets/images/stay.svg', // 通常時はstay.svg
                      width: fontSize + 15,
                      height: fontSize + 15,
                    ),
                    onDragStarted: () {
                      isDraggingNotifier.value = true; // ドラッグ開始
                    },
                    onDragEnd: (_) {
                      isDraggingNotifier.value = false; // ドラッグ終了
                    },
                    onDraggableCanceled: (_, __) {
                      isDraggingNotifier.value = false; // キャンセル時もfalse
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
