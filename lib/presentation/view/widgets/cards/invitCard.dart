import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:takwira/presentation/managers/AddressManager.dart';

import '../../../../domain/entities/Player.dart';

class InvitCard extends StatelessWidget {
  final Player player;
  const InvitCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.defaultSize.height * 0.12,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Container(
            width: ScreenUtil.defaultSize.width * 0.25,
            child: Text(
              overflow: TextOverflow.clip,
              player.nickname,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            )),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 16.sp,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      player.addressId.toString(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.run_circle,
                      size: 16.sp,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      player.preferredPosition.name,
                      style: TextStyle(
                        fontSize: 13.sp,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        Spacer(),
        Checkbox(value: true, onChanged: ((value) {}))
      ]),
    );
  }
}
 /* Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              player.nickname,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: ScreenUtil.defaultSize.width * 0.25.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 13.sp,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      player.addressId.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil.defaultSize.width * 0.25.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.directions_run,
                      color: Colors.grey,
                      size: 13.sp,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      player.preferredPosition.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );}} */
