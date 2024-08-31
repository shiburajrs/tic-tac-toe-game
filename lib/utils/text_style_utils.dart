import 'package:flutter/material.dart';

class TextStyles {
  static const double _defaultFontSize = 14.0;
  static const Color _defaultColor = Colors.black;
  static const FontWeight _defaultFontWeight = FontWeight.normal;

  // Regular style
  static TextStyle regular({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = _defaultFontWeight,
    String fontFamily = 'Oswald',
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  // Bold style
  static TextStyle bold({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = FontWeight.bold,
    String fontFamily = 'Oswald',
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  // Light style
  static TextStyle light({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = FontWeight.w300,
    String fontFamily = 'Oswald',
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  // Medium style
  static TextStyle medium({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = FontWeight.w500,
    String fontFamily = 'Oswald',
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  // Regular style
  static TextStyle cavetRegular({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = _defaultFontWeight,
    String fontFamily = 'Caveat',
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  // Bold style
  static TextStyle cavetBold({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = FontWeight.bold,
    String fontFamily = 'Caveat',
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle custom({
    double fontSize = _defaultFontSize,
    Color color = _defaultColor,
    FontWeight fontWeight = _defaultFontWeight,
    String fontFamily = 'Oswald',
    TextDecoration decoration = TextDecoration.none,
    double letterSpacing = 2,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }
}
