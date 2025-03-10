import 'package:flutter/material.dart';
import 'package:swipe_transfer_2/features/home/widgets/Station_widget.dart';

class Stations extends StatelessWidget {
  const Stations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        const Station(name: '新宿'),
        const Station(name: '渋谷'),
        const Station(name: '東京'),
      ],
    );
  }
}
