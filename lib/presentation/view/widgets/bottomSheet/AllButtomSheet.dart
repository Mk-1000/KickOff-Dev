import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class AllBottomSheet {
  void FunBottomSheet (BuildContext context, Widget widget ) {
    showCupertinoModalBottomSheet(
      // transitionBackgroundColor: Color(0xFF6E9A10), 
  context: context,
  builder: (context) => 
  Container(
    color: Colors.white,
    height:MediaQuery.of(context).size.height*0.82 ,
    child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          height: 5,
          width: 80,
          decoration: const BoxDecoration(
            color: Color(0xFFCDCFD0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        widget
      ],),
    ),
    ),
);
  }
}