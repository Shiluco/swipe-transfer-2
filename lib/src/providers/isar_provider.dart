import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipe_transfer_2/src/models/station.dart'; // Isarモデルのインポート

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory(); // DB保存用のディレクトリ取得
  return await Isar.open([StationSchema], directory: dir.path); // Isarデータベースを開く
});
