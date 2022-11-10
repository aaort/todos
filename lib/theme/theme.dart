import 'package:flutter/material.dart';
import 'package:todos/theme/constants.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: primaryColor,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColor,
    accentColor: primaryColor,
  ),
  textTheme: const TextTheme(
    titleSmall: titleSmall,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    bodyLarge: bodyLarge,
  ),
  iconTheme: iconThemeData,
  disabledColor: primaryColor.shade200,
  inputDecorationTheme: inputDecorationThemeData,
  floatingActionButtonTheme: floatingActionButtonThemeData,
  textButtonTheme: textButtonThemeData,
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: appBarTheme,
  bottomSheetTheme: bottomSheetThemeData,
  checkboxTheme: checkBoxThemeData,
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: backgroundDarkColor,
  primaryColor: primaryDarkColor,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: primaryDarkColor,
  ),
  textTheme: TextTheme(
    titleSmall: titleSmall.copyWith(color: primaryDarkColor),
    bodyMedium: bodyMedium.copyWith(color: primaryDarkColor),
    bodySmall: bodySmall.copyWith(color: primaryDarkColor),
    bodyLarge: bodyLarge.copyWith(color: primaryDarkColor),
  ),
  iconTheme: iconThemeData.copyWith(color: primaryDarkColor),
  disabledColor: primaryDarkColor.withOpacity(0.2),
  inputDecorationTheme: inputDecorationThemeData,
  floatingActionButtonTheme: floatingActionButtonThemeData.copyWith(
    backgroundColor: primaryDarkColor,
  ),
  textButtonTheme: textButtonThemeData,
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: appBarTheme.copyWith(color: backgroundDarkColor),
  bottomSheetTheme: bottomSheetThemeData,
  checkboxTheme: checkBoxThemeData.copyWith(
    fillColor: MaterialStateProperty.all(primaryDarkColor),
    checkColor: MaterialStateProperty.all(Colors.black),
    side: const BorderSide(color: primaryDarkColor),
  ),
);
