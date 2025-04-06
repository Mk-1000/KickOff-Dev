import 'package:flutter/cupertino.dart';
import 'package:takwira/presentation/view/Home/home_page.dart';

class NavData {
  NavData._internal();
  int indexPage = 1;
  List<Widget> pages = [
    Container(),
    Container(),
    Container(),
  ];
  static final NavData _singleton = NavData._internal();
  factory NavData() {
    return _singleton;
  }
}
