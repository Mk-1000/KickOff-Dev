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
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.black,
          )
        ],
      );
    }

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavData().indexPage,
        onTap: (int index) async {
          setState(() => NavData().indexPage = index); // Update the index
        },
      ),
      body: Stack(
        children: [
          NavData().pages[
              NavData().indexPage], // Display the widget at the current index
        ],
      ),
    );
  }
}
