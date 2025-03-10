import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Station extends StatelessWidget {
  final String name;

  const Station({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20; // 大きめのフォントサイズ

    return Padding(
      padding: EdgeInsets.only(bottom:60,left: 15, right: 30), // 両脇に10の余白
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SvgPicture.asset(
            'assets/images/stay.svg',
            width: fontSize+15,
            height: fontSize+15,
          ),
        ],
      ),
    );
  }
}
