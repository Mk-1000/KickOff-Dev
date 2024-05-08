import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takwira/presentation/view/NavBar/NavData.dart';
import 'package:takwira/presentation/view/NavBar/navBarMain.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


import '../themes/themes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    Widget element(dynamic icon, String text, int index) {
      return GestureDetector(
        onTap: (() {
          NavData().indexPage = index;
          NavBarMainState.controller.add(0);
        }),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2),
            //  color: widget.currentIndex == index? Theme.of(context).primaryColor :Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          height: 48,
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (text == "KickOff") ...{
                SvgPicture.asset(
                  "assets/image/logo_ligth.svg",
                  height: widget.currentIndex == index ? 20 : 30,
                  width: widget.currentIndex == index ? 20 : 30,
                )
              } else ...{
                Icon(
                  icon,
                  color: Colors.black,
                  size:  widget.currentIndex == index ? 25: 30,
                ),
              },
              SizedBox(
                width: 4,
              ),
              if (widget.currentIndex == index) ...{
                AllText.Autotext(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    text: text)
              }
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 70,
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          element(Icons.home_outlined, "Home", 0),
          element(Icons.sports_soccer_rounded, "KickOff", 1),
          element(Icons.person_outline, "Profile", 2),
        ],
      ),
    );

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      // selectedLabelStyle: MyAppLocalizations().textStyle(context,
      //  fontSize: 10,
      //                                     fontWeight: FontWeight.w500,color: Account().darkmod ? Colors.white: Colors.black),
      //                                     unselectedLabelStyle:        MyAppLocalizations().textStyle(
      //                                     context,
      //                                     fontSize: 10,
      //                                     fontWeight: FontWeight.w500,color: Account().darkmod ? Colors.white: Colors.black),
      type: BottomNavigationBarType.fixed, // Add this line
      selectedItemColor: Color(0xFF6E9A10),
      unselectedItemColor: Colors.white,
      currentIndex: widget.currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            height: 20,
            width: 20,
            widget.currentIndex == 0
                ? "assets/icons/ActivehomeIcon.png"
                : "assets/icons/homeIcon.png",
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            height: 20,
            width: 20,
            widget.currentIndex == 1
                ? "assets/icons/activeFavorite.png"
                : "assets/icons/Favorite.png",
          ),
          label: "KickOff",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            height: 20,
            width: 20,
            widget.currentIndex == 2
                ? "assets/icons/activeFire.png"
                : "assets/icons/Fire.png",
          ),
          label: "Profile",
        ),
      ],
      onTap: widget.onTap,
    );
  }
}
