import 'package:flutter/material.dart';
import 'package:swipe_transfer_2/features/home/widgets/templates/stations_widget.dart';
import 'package:swipe_transfer_2/features/home/widgets/templates/app_bar_widget.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          const SizedBox(height: 30),
          const Expanded(child: Center(child: Stations())),
        ],
      ),
    );
  }
}
