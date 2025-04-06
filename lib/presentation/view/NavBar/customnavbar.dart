import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takwira/presentation/view/NavBar/NavData.dart';
import 'package:takwira/presentation/view/NavBar/navBarMain.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget element(dynamic icon, String text, int index) {
      return GestureDetector(
        onTap: () => onTap(index), // Call the provided onTap callback
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2.w),
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          height: 48.h,
          width: 110.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (text == "KickOff") ...{
                SvgPicture.asset(
                  "assets/image/logo_ligth.svg",
                  height: currentIndex == index ? 20 : 30,
                  width: currentIndex == index ? 20 : 30,
                )
              } else ...{
                Icon(
                  icon,
                  color: Colors.black,
                  size: currentIndex == index ? 25 : 30,
                ),
              },
              SizedBox(
                width: 4.w,
              ),
              if (currentIndex == index) ...{
                AllText.Autotext(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    text: text)
              }
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          element(Icons.home_outlined, "Home", 0),
          element(Icons.sports_soccer_rounded, "KickOff", 1),
          element(Icons.stadium_outlined, "Stades", 2),
        ],
      ),
    );
  }
}
