import 'package:flutter/material.dart';
import 'package:todos/theme/constants.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: kPrimaryColor,
  primaryColor: kPrimaryColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: kPrimaryColor,
    accentColor: kPrimaryColor,
    errorColor: kErrorColor,
  ),
  textTheme: const TextTheme(
    titleLarge: titleLarge,
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
  bottomSheetTheme: bottomSheetThemeData,
  checkboxTheme: checkBoxThemeData,
  listTileTheme: listTileThemeData,
  textSelectionTheme: textSelectionThemeData,
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundDarkColor,
  primaryColor: kPrimaryDarkColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: kPrimaryDarkColor,
    accentColor: kPrimaryDarkColor,
    errorColor: kErrorColor,
  ),
  textTheme: TextTheme(
    titleLarge: titleLarge,
    titleSmall: titleSmall.copyWith(color: kPrimaryDarkColor),
    bodyMedium: bodyMedium.copyWith(color: kPrimaryDarkColor),
    bodySmall: bodySmall.copyWith(color: kPrimaryDarkColor),
    bodyLarge: bodyLarge.copyWith(color: kPrimaryDarkColor),
  ),
  iconTheme: iconThemeData.copyWith(color: kPrimaryDarkColor),
  disabledColor: kPrimaryDarkColor.withOpacity(0.2),
  inputDecorationTheme: inputDecorationThemeData,
  floatingActionButtonTheme: floatingActionButtonThemeData,
  textButtonTheme: textButtonThemeData,
  elevatedButtonTheme: elevatedButtonThemeData,
  bottomSheetTheme:
      bottomSheetThemeData.copyWith(backgroundColor: kBackgroundDarkColor),
  checkboxTheme: checkBoxThemeData.copyWith(
    fillColor: MaterialStateProperty.all(kPrimaryDarkColor),
    checkColor: MaterialStateProperty.all(kBackgroundDarkColor),
    side: const BorderSide(color: kPrimaryDarkColor),
  ),
  listTileTheme: listTileThemeData,
  textSelectionTheme: textSelectionThemeData.copyWith(
    cursorColor: kPrimaryDarkColor,
  ),
);
