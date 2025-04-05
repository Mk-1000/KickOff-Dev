import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/NavBar/NavData.dart';

import 'customnavbar.dart';

class NavBarMain extends StatefulWidget {
  const NavBarMain({super.key});

  @override
  State<NavBarMain> createState() => NavBarMainState();
}

class NavBarMainState extends State<NavBarMain> {
  static StreamController<double> controller =
      StreamController<double>.broadcast();
  @override
  void initState() {
    Stream stream = controller.stream;
    stream.listen((value) {
      setState(() => NavData().indexPage = NavData().indexPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget itemSidebar(String text, String image) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05),
                child: AutoSizeText(
                  text,
                  // style: MyAppLocalizations()
                  //     .textStyle(context,
                  //     color: Account().darkmod ?Colors.white: Colors.black,fontSize: 14,fontWeight:FontWeight.w600 ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Container(
              child: const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.black,
          ))
        ],
      );
    }

    return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: NavData().indexPage,
          onTap: (int index) async {
            print("heeeeelo");
            setState(() => NavData().indexPage = NavData().indexPage);

            //         if(index == 0 || index == 2 ) {

            //           setState(() =>  NavData().indexPage = index);
            //         }else {
            //           if (Account().accountID == "Guest" || Account().complet_sign_in == false) {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) =>  Login()),
            //             );
            //           }else if (Account().forgin) {
            //             Popups_Manger().warningPopup(context,AppLocalizations.of(context)!.feature_not_availbe);
            //           }else {
            //             if(index == 4) {
            //                  Popups_Manger().soon(context,AppLocalizations.of(context)!.featureSoon);

            //             }else {

            //                 // Account().favorite = [] ;
            // setState(() =>  NavData().indexPage = index);
            //             }
            //           }
            //         }
          },
        ),
        body: Stack(
          children: [
            NavData().pages[NavData().indexPage],
            //  Positioned(
            //     top: 75,
            //     left: size.width*0.45,
            //     right: size.width*0.45,
            //     child: image() ,

            //  )
          ],
        ));

    //   WillPopScope(
    //     onWillPop: () async {
    //      // Get.back();
    //       return await false ;
    //     },
    //     child: CupertinoTabScaffold(tabBar: CupertinoTabBar(
    //         activeColor : Color(0xFF6E9A10),
    //       onTap: (index) {
    //         setState(() => NavData().indexPage = index);
    //       },
    //       currentIndex: NavData().indexPage,
    //       items:  <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Image.asset(
    //             height:30 ,
    //             width: 30,
    //             NavData().indexPage== 0 ?"assets/icons/ActivehomeIcon.png": "assets/icons/homeIcon.png",),
    //           label: 'Home',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Image.asset(
    //             height:30 ,
    //             width: 30,
    //             NavData().indexPage == 1 ?"assets/icons/activeFavorite.png": "assets/icons/Favorite.png",),
    //           label: 'Favorites',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Image.asset(
    //             height:30 ,
    //             width: 30,
    //             NavData().indexPage == 2 ?"assets/icons/activeFire.png": "assets/icons/Fire.png",),
    //           label: 'Guess',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Image.asset(
    //             height:30 ,
    //             width: 30,
    //             NavData().indexPage == 3 ?"assets/icons/activeHistory.png": "assets/icons/History.png",),
    //           label: 'History',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Image.asset(
    //             height:30 ,
    //             width: 30,
    //             NavData().indexPage == 4 ?"assets/icons/activereward1.png": "assets/icons/reward1.png",),
    //           label: 'Reward',
    //         ),
    //       ],
    //     ),
    //         tabBuilder: (BuildContext context, int index) {
    //
    //           return CupertinoTabView(
    //             builder: (BuildContext context) {
    //               return CupertinoPageScaffold(
    //                 child: NavData().pages [index],
    //               );
    //             },
    //           );
    //         }
    //
    // )
    //
    //
    // ,) ;
  }
}
