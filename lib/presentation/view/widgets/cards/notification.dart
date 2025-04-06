import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.05), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(47)),
            child: CahedImage(
              img:
                  "https://images.axios.com/JIqTJp0sjfmhTz7Q7zfeq_vrcUU=/0x148:5071x3000/1920x1080/2022/11/25/1669384070045.jpg",
              height: 44.w,
              width: 44.w,
              box: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.max, // Make the column take all available space
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the text vertically
              children: [
                AllText.Autotext(
                  text: "game alert!",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).shadowColor,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Flexible(
                  // Makes text wrap and fill the container
                  child: AllText.Autotext(
                      text:
                          "The match between Real Madrid and Barcelona has been started!",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
