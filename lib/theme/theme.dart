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
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: backgroundDarkColor,
  primaryColor: primaryDarkColor,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: primaryDarkColor,
  ),
  textTheme: TextTheme(
    titleSmall: titleSmall.copyWith(color: Colors.white),
    bodyMedium: bodyMedium.copyWith(color: Colors.white),
    bodySmall: bodySmall.copyWith(color: Colors.white),
    bodyLarge: bodyLarge.copyWith(color: Colors.white),
  ),
  iconTheme: iconThemeData,
  disabledColor: primaryColor.shade200,
  inputDecorationTheme: inputDecorationThemeData,
  floatingActionButtonTheme: floatingActionButtonThemeData,
  textButtonTheme: textButtonThemeData,
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: appBarTheme.copyWith(color: backgroundDarkColor),
  bottomSheetTheme: bottomSheetThemeData,
);
