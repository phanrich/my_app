import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppTheme { dark, light }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 72.0.sp, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36.0.sp, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0.sp, fontFamily: 'Hind'),
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black45,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 72.0.sp, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36.0.sp, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0.sp, fontFamily: 'Hind'),
    ),
  )
};
