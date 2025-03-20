import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart'; 

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
        return DragTarget<Map<String, dynamic>>(
          onAcceptWithDetails: (details) async {
            String start = Uri.encodeComponent(details.data['name']); // 出発駅
            String goal = Uri.encodeComponent(name); // 目的駅

            String url =
                "https://transit.yahoo.co.jp/search/result?flatlon=&fromgid=&from=$start&to=$goal&viacode=&via=&viacode=&via=&viacode=&via=&type=1&ticket=ic&expkind=1&ws=3&s=0&al=1&shin=1&ex=1&hb=1&lb=1&sr=1";

            // ブラウザで開く
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.inAppWebView,
              );
            } else {
              print("URLを開けませんでした");
            }
          },
          builder: (context, candidateData, rejectedData) {
            bool isHovered = candidateData.isNotEmpty; // ドロップ対象の上にいるか

            return Padding(
              padding: const EdgeInsets.only(bottom: 60, left: 25, right: 30),
              child: Opacity(
                opacity: isHovered ? 0.5 : 1.0, // ドロップされる側の透明度変更
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
                    Draggable<Map<String, dynamic>>(
                      data: {'id': id, 'name': name}, // idとnameを渡す
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
              ),
            );
          },
        );
      },
    );
  }
}
