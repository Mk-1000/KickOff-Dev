import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/StadeDetail/StadeDetails.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class StadeCard extends StatelessWidget {
  final int index;
  final bool borderBlue;
  const StadeCard({super.key, required this.index, this.borderBlue = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StadeDetails()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        height: 82.h,
        decoration: BoxDecoration(
          border: Border.all(
              color: borderBlue
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).bottomAppBarColor,
              width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Hero(
              tag: "stade" + index.toString(),
              child: Container(
                height: 82.h,
                width: 88.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                  child: Image.network(
                    "https://images.midilibre.fr/api/v1/images/view/633da2e473564570454b7579/large-fit/image.jpg?v=1",
                    height: 82.h,
                    width: 88.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              width: 2.w,
              height: 100.h,
              color: Theme.of(context).bottomAppBarColor,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AllText.Autotext(
                      color: Theme.of(context).shadowColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      text: 'MAY Foot Land'),
                  Row(
                    children: [
                      Icon(Icons.place_outlined, size: 16),
                      Text(
                        "Monastir / MAY Foot Land",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined, size: 16),
                      Text(
                        "24 Jan 2024 / 23:00 H",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        alignment: Alignment.center,
                        height: 16.sp,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                        child: AllText.Autotext(
                            text: "8 DT",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
