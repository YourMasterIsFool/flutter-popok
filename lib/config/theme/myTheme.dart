import 'package:flutter/material.dart';
import 'package:pos_flutter/config/style/style.dart';

ThemeData myTheme() {
  return ThemeData(
      colorScheme: colorSceme(),
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
      errorBorder: errorBorder,
      focusedBorder: focusedBorder,
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
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.pressed)
                  ? primaryColor.withOpacity(0.8)
                  : primaryColor)));
}
