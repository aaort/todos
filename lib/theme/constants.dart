import 'package:flutter/material.dart';

const Map<int, Color> primaryColorMap = {
  50: Color(0xff3B3936),
  100: Color(0xff3B3936),
  200: Color(0xff3B3936),
  300: Color(0xff3B3936),
  400: Color(0xff3B3936),
  500: Color(0xff3B3936),
  600: Color(0xff3B3936),
  700: Color(0xff3B3936),
  800: Color(0xff3B3936),
  900: Color(0xff3B3936),
};

const kPrimaryColor = MaterialColor(0xff3B3936, primaryColorMap);
const kModalBorderRadius = 20.0;
const kPrimaryDarkColor = Colors.white;
final kBackgroundDarkColor = Colors.black.withOpacity(0.9);
const kButtonElevation = 2.0;
const kListTileLeftPadding = 10.0;

const titleLarge = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.w600,
);

const titleSmall = TextStyle(
  color: kPrimaryColor,
  fontSize: 25.0,
  fontWeight: FontWeight.w600,
);

const bodyMedium = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

const bodySmall = TextStyle(
  color: kPrimaryColor,
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
);

const bodyLarge = TextStyle(
  color: kPrimaryColor,
  fontSize: 30.0,
  fontWeight: FontWeight.w600,
);

const textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStatePropertyAll(bodySmall),
  ),
);

const floatingActionButtonThemeData = FloatingActionButtonThemeData(
  backgroundColor: kPrimaryColor,
  elevation: 2.0,
);

const iconThemeData = IconThemeData(
  color: kPrimaryColor,
  size: 27,
);

const bottomSheetThemeData = BottomSheetThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(kModalBorderRadius),
    ),
  ),
  backgroundColor: Colors.white,
);

const inputDecorationThemeData = InputDecorationTheme(
  border: InputBorder.none,
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: const MaterialStatePropertyAll(kButtonElevation),
    backgroundColor: const MaterialStatePropertyAll(kPrimaryColor),
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
  ),
);

final checkBoxThemeData = CheckboxThemeData(
  checkColor: MaterialStateProperty.all(Colors.white),
  fillColor: MaterialStateProperty.all(kPrimaryColor),
  side: const BorderSide(color: kPrimaryColor, width: 1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  ),
);

const listTileThemeData = ListTileThemeData(
  contentPadding: EdgeInsets.only(left: kListTileLeftPadding),
);

const textSelectionThemeData = TextSelectionThemeData(
  cursorColor: kPrimaryColor,
);
