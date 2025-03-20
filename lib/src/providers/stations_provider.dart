import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_transfer_2/src/models/station.dart';


// 駅リストのプロバイダ
final stationsProvider = StateProvider<List<Station>>((ref) => []);
