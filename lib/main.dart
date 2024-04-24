import 'package:flutter/material.dart';
import 'package:takwira/view/Onbording/Onbording.dart';
import 'package:takwira/view/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes().lightTheme,
      home: Onbording(),
    );
  }
}
