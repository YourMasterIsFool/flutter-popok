import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/config/style/style.dart';

ThemeData myTheme() {
  return ThemeData(
      colorScheme: colorSceme(),
      scaffoldBackgroundColor: Colors.grey.shade100,
      appBarTheme: appBarTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      iconButtonTheme: iconButtonThemeData(),
      textButtonTheme: textButtonThemeData(),
      floatingActionButtonTheme: floatingActionButtonThemeData(),
      textTheme: textTheme());
}

TextTheme textTheme() {
  return TextTheme().copyWith(
    bodyLarge: textLarge,
    bodySmall: textSmall,
    bodyMedium: textNormal,
    titleLarge: textLargeTitle,
    titleMedium: textNormalTitle,
    titleSmall: textSmallTitle,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      elevation: 0,
      titleTextStyle:
          textTheme().titleMedium?.copyWith(color: Colors.grey.shade800),
      backgroundColor: Colors.grey.shade50,
      foregroundColor: Colors.grey.shade800);
}

ColorScheme colorSceme() {
  return ColorScheme.fromSeed(seedColor: Colors.black);
}

FloatingActionButtonThemeData floatingActionButtonThemeData() {
  return FloatingActionButtonThemeData(
      backgroundColor: primaryColor, foregroundColor: Colors.white);
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      errorStyle: textTheme().bodySmall?.copyWith(color: errorColor),
      errorBorder: errorBorder,
      focusedBorder: focusedBorder,
      labelStyle: textSmall,
      hintStyle: textSmall,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1)));
}

IconButtonThemeData iconButtonThemeData() {
  return IconButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              (states.contains(MaterialState.pressed)
                  ? primaryColor.withOpacity(0.8)
                  : primaryColor)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ))));
}

TextButtonThemeData textButtonThemeData() {
  return TextButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.pressed)
                  ? primaryColor.withOpacity(0.8)
                  : primaryColor)));
}
