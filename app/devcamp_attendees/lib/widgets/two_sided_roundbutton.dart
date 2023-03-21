import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TwoSidedRoundButton extends StatelessWidget {
  const TwoSidedRoundButton({
    Key? key,
    required this.text,
    this.radius = 30,
    required this.press,
    this.color = kBlackColor,
  }) : super(key: key);
  final String text;
  final double radius;
  final VoidCallback press;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius))),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ));
  }
}
