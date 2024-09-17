import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  // Weights
  TextStyle get thin => weight(FontWeight.w100);
  TextStyle get extraLight => weight(FontWeight.w200);
  TextStyle get light => weight(FontWeight.w300);
  TextStyle get regular => weight(FontWeight.normal);
  TextStyle get medium => weight(FontWeight.w500);
  TextStyle get semiBold => weight(FontWeight.w600);
  TextStyle get bold => weight(FontWeight.w700);
  TextStyle get extraBold => weight(FontWeight.w800);
  TextStyle get black => weight(FontWeight.w900);
  TextStyle get extraThickBold => weight(FontWeight.bold);
  TextStyle get italic => style(FontStyle.italic);
  TextStyle get underline => textDecoration(TextDecoration.underline);
  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);
  TextStyle get overLine => textDecoration(TextDecoration.overline);

  TextStyle textColor(Color v) => copyWith(color: v);
  TextStyle textBackgroundColor(Color v) => copyWith(backgroundColor: v);
  TextStyle size(double v) => copyWith(fontSize: v);
  TextStyle scale(double v) => copyWith(fontSize: (fontSize ?? 0) * v);
  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);
  TextStyle style(FontStyle v) => copyWith(fontStyle: v);
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);
  TextStyle wordSpace(double v) => copyWith(wordSpacing: v);
  TextStyle baseline(TextBaseline v) => copyWith(textBaseline: v);
  TextStyle textHeight(double v) => copyWith(height: v);
  TextStyle textLocale(Locale v) => copyWith(locale: v);
  TextStyle textForeground(Paint v) => copyWith(foreground: v);
  TextStyle textBackground(Paint v) => copyWith(background: v);
  TextStyle textShadows(List<Shadow> v) => copyWith(shadows: v);
  TextStyle textFeatures(List<FontFeature> v) => copyWith(fontFeatures: v);
  TextStyle textDecoration(TextDecoration v,
          {Color? color, TextDecorationStyle? style, double thickness = 1}) =>
      copyWith(
          decoration: v,
          decorationColor: color,
          decorationStyle: style,
          decorationThickness: thickness);
}
