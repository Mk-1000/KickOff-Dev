import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/presentation/view/CreateTeam/widget/CircleNumber.dart';

class Stade extends StatefulWidget {
  final int defender ; 
   final int mid ; 
    final int attack ; 

  const Stade({super.key, required this.defender, required this.mid, required this.attack});

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
            width: size.width,
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
                    for(int i = 0 ; i< widget.defender ; i++) ...{
                       CirculeNumber(
                      number: 2,
                    ), 
                    }
                  ],
                ),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // if 1 player == center
                  children: [
                    for(int i = 0 ; i< widget.mid ; i++) ...{
                       CirculeNumber(
                      number: 2,
                    ), 
                    }
                  ],
                ),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // if 1 player == center
                  children: [
                    for(int i = 0 ; i< widget.attack ; i++) ...{
                       CirculeNumber(
                      number: 2,
                    ), 
                    }
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
