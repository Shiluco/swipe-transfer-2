import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onEditTap;

  const HomeAppBar({super.key, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 60; // フォントサイズを定義

    return Padding(
      padding: const EdgeInsets.only(top: 90, left: 20, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右に分ける
        crossAxisAlignment: CrossAxisAlignment.center, // 縦方向は中央揃え
        children: [
          const Text(
            'Home',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onEditTap,
            child: SvgPicture.asset(
              'assets/images/edit.svg',
              width: fontSize - 20,
              height: fontSize - 20,
            ),
          ),
        ],
      ),
    );
  }
}
