import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:takwira/view/GoogleNavBar/Drawer.dart';
import 'package:takwira/view/Home/home_page.dart';
import 'package:takwira/view/KickOff/KickoffMain.dart';
import 'package:takwira/view/Stades/Stade.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => GoogleNavBarState();
}

class GoogleNavBarState extends State<GoogleNavBar> {
    static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    KickOff(),
    Stades()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         key: scaffoldKey,
      drawer:Drawers() ,
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).primaryColor,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              // tabBackgroundColor: Colors.grey[100]!,
              tabActiveBorder: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              color: Colors.black,
              tabs: [
                GButton(
                    textColor:Theme.of(context).primaryColor ,
                  iconActiveColor: Theme.of(context).primaryColor ,
                  icon: 
                  _selectedIndex == 0? Icons.home: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                    textColor:Theme.of(context).primaryColor ,
                   leading:Container(
                    child:     SvgPicture.asset(
                  "assets/image/logo_ligth.svg",
                  height: 20,
                  width: 20,
                ),
                    // color: Colors.amber,
                    ),
                  icon: Icons.home,
                  text: 'KickOff',
                ),
                GButton(
                  textColor:Theme.of(context).primaryColor ,
                  iconActiveColor: Theme.of(context).primaryColor ,
                  // iconColor: _selectedIndex == 2 ? Theme.of(context).shadowColor:Theme.of(context).shadowColor ,
                  icon: _selectedIndex == 2 ? Icons.stadium: Icons.stadium_outlined ,
                  text: 'Stades',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}