import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    primaryColorLight: Color(0xFF3053EC),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF3053EC),
    ),
    primarySwatch: Colors.blue,
    backgroundColor: Color(0xFFFFFFFF),
    shadowColor: Color(0xFF090A0A),
    indicatorColor: Color(0xFF3053EC),
    primaryColor: Color(0xFF3053EC),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(50.0), // Adjust the radius as needed
      ),
      backgroundColor: Color(0xFF3053EC),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Color(0xFFE3E5E5),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.white,
      shadowColor: Color(0xFFE3E5E5),
      elevation: 0,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white, // Drawer background color
    ),
  );
}
