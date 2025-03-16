import 'package:flutter/material.dart';
import 'package:swipe_transfer_2/src/features/home/widgets/templates/stations_widget.dart';
import 'package:swipe_transfer_2/src/features/home/widgets/templates/app_bar_widget.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppBar(
            onEditTap: () {
              context.go('/edit');
            },
          ),

          const SizedBox(height: 30),
          Expanded(child: Center(child: StationsWidget())),
        ],
      ),
    );
  }
}
