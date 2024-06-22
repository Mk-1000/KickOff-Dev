import 'package:flutter/material.dart';

class Postion extends StatefulWidget {
  const Postion({super.key});

  @override
  State<Postion> createState() => PostionState();
}

class PostionState extends State<Postion> {
  static int? selected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 4; i++) ...{
          GestureDetector(
            onTap: () {
              setState(() {
                  selected = i;
              });
            },
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(top: 75, left: 23),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                border: i== selected ? Border.all(
                  color: Color(0xFF3053EC),
                  width: 4,
                ): Border.all(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/image/$i.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        },
      ],
    );
  }
}
