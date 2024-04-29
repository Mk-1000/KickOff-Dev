import 'package:flutter/material.dart';

class Themes {
  ThemeData lightTheme = ThemeData(
      primarySwatch: const MaterialColor(0xFF3053EC, {
        50: Color(0xFFE3EAFD),
        100: Color(0xFFB8CCF8),
        200: Color(0xFF8AAFF3),
        300: Color(0xFF5C91EF),
        400: Color(0xFF3C7BE9),
        500: Color(0xFF3053EC), // Your primary color
        600: Color(0xFF2948CA),
        700: Color(0xFF213DA8),
        800: Color(0xFF183285),
        900: Color(0xFF0D1F63),
      }),
      shadowColor: Color(0xFF090A0A),
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Color(0xFFE3E5E5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
      ));
}
