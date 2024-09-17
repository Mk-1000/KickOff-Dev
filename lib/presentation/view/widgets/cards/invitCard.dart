import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/managers/AddressManager.dart';

import '../../../../domain/entities/Player.dart';

class InvitCard extends StatelessWidget {
  final Player player;
  const InvitCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              player.nickname,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.place_outlined,
                size: 16.sp,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                player.addressId.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.directions_run,
                color: Colors.grey,
                size: 13.sp,
              ),
              Text(
                player.preferredPosition.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
