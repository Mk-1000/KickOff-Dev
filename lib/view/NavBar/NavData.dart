import 'package:flutter/cupertino.dart';
import 'package:takwira/view/Home/home_page.dart';



class NavData {
  NavData._internal() {}
  int indexPage = 0 ;
  List<Widget> pages = [HomePage(),Container(),Container()] ;
  static final NavData _singleton = NavData._internal();
  factory NavData() {
    return _singleton;
  }
}