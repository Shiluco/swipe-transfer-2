import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/common/router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipe_transfer_2/src/models/station.dart'; // Isarモデルのインポート

late Isar isar; // Isarインスタンスをグローバル変数として定義

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 非同期処理のため

  final dir = await getApplicationDocumentsDirectory(); // DB保存用のディレクトリ取得
  isar = await Isar.open([StationSchema], directory: dir.path); // Isarデータベースを開く

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Swipe Transfer App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // システム設定に合わせて切り替え
    );
  }
}
