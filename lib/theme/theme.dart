import 'package:flutter/material.dart';
import 'package:todos/theme/constants.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: kPrimaryColor,
  primaryColor: kPrimaryColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: kPrimaryColor,
    accentColor: kPrimaryColor,
  ),
  textTheme: const TextTheme(
    titleSmall: titleSmall,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    bodyLarge: bodyLarge,
  ),
  iconTheme: iconThemeData,
  disabledColor: kPrimaryColor.shade200,
  inputDecorationTheme: inputDecorationThemeData,
  floatingActionButtonTheme: floatingActionButtonThemeData,
  textButtonTheme: textButtonThemeData,
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: appBarTheme,
  bottomSheetTheme: bottomSheetThemeData,
  checkboxTheme: checkBoxThemeData,
  listTileTheme: listTileThemeData,
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundDarkColor,
  primaryColor: kPrimaryDarkColor,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: kPrimaryDarkColor,
  ),
  textTheme: TextTheme(
    titleSmall: titleSmall.copyWith(color: kPrimaryDarkColor),
    bodyMedium: bodyMedium.copyWith(color: kPrimaryDarkColor),
    bodySmall: bodySmall.copyWith(color: kPrimaryDarkColor),
    bodyLarge: bodyLarge.copyWith(color: kPrimaryDarkColor),
  ),
  iconTheme: iconThemeData.copyWith(color: kPrimaryDarkColor),
  disabledColor: kPrimaryDarkColor.withOpacity(0.2),
  inputDecorationTheme: inputDecorationThemeData,
  floatingActionButtonTheme: floatingActionButtonThemeData.copyWith(
    backgroundColor: kPrimaryDarkColor,
  ),
  textButtonTheme: textButtonThemeData,
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: appBarTheme.copyWith(color: kBackgroundDarkColor),
  bottomSheetTheme:
      bottomSheetThemeData.copyWith(backgroundColor: kBackgroundDarkColor),
  checkboxTheme: checkBoxThemeData.copyWith(
    fillColor: MaterialStateProperty.all(kPrimaryDarkColor),
    checkColor: MaterialStateProperty.all(kBackgroundDarkColor),
    side: const BorderSide(color: kPrimaryDarkColor),
  ),
  listTileTheme: listTileThemeData,
);
