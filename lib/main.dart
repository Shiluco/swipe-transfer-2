import 'package:flutter/material.dart';
import 'package:swipe_transfer_2/features/home/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Transfer App',
      home: const HomeView(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // システム設定に合わせて切り替え
    );
  }
}
