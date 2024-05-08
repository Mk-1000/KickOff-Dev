import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


class CirculeNumber extends StatelessWidget {
  final int number;
  const CirculeNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 29),
      alignment: Alignment.center,
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
      ),
      child: AllText.Autotext(
          text: number.toString(),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).shadowColor),
    );
  }
}
