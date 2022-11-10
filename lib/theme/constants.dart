import 'package:flutter/material.dart';

const primaryColor = Colors.blueGrey;
const kModalBorderRadius = 20.0;
const primaryDarkColor = Colors.white;
final backgroundDarkColor = Colors.black.withOpacity(0.9);

const titleSmall = TextStyle(
  color: primaryColor,
  fontSize: 25.0,
  fontWeight: FontWeight.w600,
);

const bodyMedium = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

const bodySmall = TextStyle(
  color: primaryColor,
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
);

const bodyLarge = TextStyle(
  color: primaryColor,
  fontSize: 30.0,
  fontWeight: FontWeight.w600,
);

final textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.resolveWith(getButtonTextStyle),
  ),
);

const appBarTheme = AppBarTheme(
  elevation: 0,
  titleSpacing: 15.0,
  backgroundColor: primaryColor,
  titleTextStyle: TextStyle(
    color: primaryDarkColor,
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
  ),
);

const floatingActionButtonThemeData = FloatingActionButtonThemeData(
  backgroundColor: primaryColor,
  elevation: 2.0,
);

const iconThemeData = IconThemeData(
  color: primaryColor,
  size: 27,
);

final bottomSheetThemeData = BottomSheetThemeData(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(kModalBorderRadius),
    ),
  ),
  backgroundColor: backgroundDarkColor,
);

const inputDecorationThemeData = InputDecorationTheme(
  border: InputBorder.none,
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: MaterialStateProperty.resolveWith(getButtonElevation),
    backgroundColor: MaterialStateProperty.resolveWith(getButtonColor),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
  ),
);

final checkBoxThemeData = CheckboxThemeData(
  checkColor: MaterialStateProperty.all(Colors.white),
  fillColor: MaterialStateProperty.all(primaryColor),
  side: const BorderSide(color: Colors.blueGrey, width: 1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
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
