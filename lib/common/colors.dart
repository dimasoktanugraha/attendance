import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF031727);
  static const Color grey = Color(0xFF969696);
  static const Color primary = Color(0xFFF89F1E);
  static const Color secondary = Color(0xFFE71D35);
  static const Color background = Color(0xFFF0F0F0);
  static const Color white = Color(0xffFFFFFF);

  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white
  );
}


