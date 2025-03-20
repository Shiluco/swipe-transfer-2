import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/common/router.dart';
import 'package:swipe_transfer_2/src/providers/isar_provider.dart'; // Isarのプロバイダをインポート

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 非同期処理のため

  runApp(const ProviderScope(child: MyApp())); // Riverpodのプロバイダをラップ
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isarAsync = ref.watch(isarProvider); // Isarの初期化状態を監視

    return isarAsync.when(
      data:
          (_) => MaterialApp.router(
            routerConfig: router,
            title: 'Swipe Transfer App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system, // システム設定に合わせて切り替え
          ),
      loading: () => const CircularProgressIndicator(), // Isar 初期化中
      error:
          (err, stack) => MaterialApp(
            home: Scaffold(body: Center(child: Text("Error: $err"))),
          ),
    );
  }
}
