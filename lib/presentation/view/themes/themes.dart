import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    primaryColorLight: const Color(0xFF3053EC),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3053EC),
    ),
    primarySwatch: Colors.blue,
  
    shadowColor: const Color(0xFF090A0A),
    indicatorColor: const Color(0xFF3053EC),
    primaryColor: const Color(0xFF3053EC),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(50.0), // Adjust the radius as needed
      ),
      backgroundColor: const Color(0xFF3053EC),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarTheme:  const BottomAppBarTheme (color:Color(0xFFE3E5E5) ) ,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.white,
      shadowColor: Color(0xFFE3E5E5),
      elevation: 0,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white, // Drawer background color
    ),
  );
}
