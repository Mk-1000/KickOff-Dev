import 'package:flutter/material.dart';

import '../../../../domain/entities/Player.dart';

class InvitCard extends StatelessWidget {
 final  Player player ;
  const InvitCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(""),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 10),
          Text(
            player.nickname,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            player.preferredPosition.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
       
     
    ],) ;
  }
}