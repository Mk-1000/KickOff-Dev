import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllText {
  static Widget Autotext({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign textAlign = TextAlign.center,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    double? minFontSize,
    double? maxFontSize,
  }) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      style: GoogleFonts.rubik(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      overflow: overflow,
      maxLines: maxLines,
      minFontSize: minFontSize ?? 12,
      maxFontSize: maxFontSize ?? double.infinity,
    );
  }
}
