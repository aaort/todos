import 'package:flutter/material.dart';

final themeData = ThemeData(
  scaffoldBackgroundColor: Colors.blueGrey,
  primaryColor: Colors.blueGrey,
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
      color: Colors.blueGrey,
      fontSize: 25.0,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: Colors.blueGrey,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.blueGrey,
      fontSize: 30.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.blueGrey,
    size: 27,
  ),
  disabledColor: Colors.blueGrey.shade200,
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey,
    elevation: 2.0,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.blueGrey,
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
      shape: MaterialStateProperty.resolveWith(
        (_) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
  ),
);

double getButtonElevation(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return 0;
  } else {
    return 2.0;
  }
}

Color getButtonColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blueGrey.shade200;
  }
  return Colors.blueGrey;
}

TextStyle getButtonTextStyle(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled
  };
  if (states.any(interactiveStates.contains)) {
    return TextStyle(color: Colors.blueGrey.shade200);
  }
  return const TextStyle(color: Colors.blueGrey);
}