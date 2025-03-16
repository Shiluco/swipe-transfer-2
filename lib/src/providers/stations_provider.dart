import 'package:flutter_riverpod/flutter_riverpod.dart';

// 駅のモデル
class Station {
  final int id;
  final String name;

  Station({required this.id, required this.name});
}

// 駅リストのプロバイダ
final stationsProvider = StateProvider<List<Station>>((ref) => []);
