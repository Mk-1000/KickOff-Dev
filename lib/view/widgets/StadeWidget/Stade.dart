import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/view/CreateTeam/widget/CircleNumber.dart';

class Stade extends StatefulWidget {
  const Stade({super.key});

  @override
  State<Stade> createState() => _StadeState();
}

class _StadeState extends State<Stade> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          SvgPicture.asset(
            width:size.width, 
            "assets/image/stade.svg",
            fit: BoxFit.contain,
          ),
          Positioned.fill(
            // Use Positioned.fill to make the Row take the full size of the Stack
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CirculeNumber(
                  number: 1,
                ), // gardient
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // if 1 player == center
                  children: [
                    CirculeNumber(
                      number: 2,
                    ), //
                    CirculeNumber(
                      number: 3,
                    ), //
                  ],
                ),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // if 1 player == center
                  children: [
                    CirculeNumber(
                      number: 4,
                    ), //
                  ],
                ),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // if 1 player == center
                  children: [
                    CirculeNumber(
                      number: 5,
                    ), //
                    CirculeNumber(
                      number: 6,
                    ), //
                    CirculeNumber(
                      number: 7,
                    ), //
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
