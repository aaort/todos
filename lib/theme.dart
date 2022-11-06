import 'package:flutter/material.dart';

const primaryColor = Colors.blueGrey;

final themeData = ThemeData(
  scaffoldBackgroundColor: primaryColor,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColor,
    accentColor: primaryColor,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w800,
    ),
    titleSmall: TextStyle(
      color: primaryColor,
      fontSize: 25.0,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      color: primaryColor,
      fontSize: 30.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
    size: 27,
  ),
  disabledColor: primaryColor.shade200,
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    elevation: 2.0,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: primaryColor,
    actionTextColor: Colors.white,
    elevation: 2.0,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith(getButtonTextStyle),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.resolveWith(getButtonElevation),
      backgroundColor: MaterialStateProperty.resolveWith(getButtonColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    titleSpacing: 15.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w800,
    ),
  ),
);

double getButtonElevation(Set<MaterialState> states) =>
    states.contains(MaterialState.disabled) ? 2.0 : 0;

Color getButtonColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return primaryColor.shade200;
  }
  return primaryColor;
}

TextStyle getButtonTextStyle(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return TextStyle(color: primaryColor.shade200);
  }
  return const TextStyle(color: primaryColor);
}
