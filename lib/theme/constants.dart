import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todos/theme/material_colors.dart';

const kPrimaryColor = MaterialColor(0xff3B3936, primaryColorMap);
const kBackgroundColor = kPrimaryDarkColor;
const kPrimaryDarkColor = MaterialColor(0xfff2f2f2, primaryDarkColorMap);
const kBackgroundDarkColor = kPrimaryColor;
const kErrorColor = Color(0xffBD2A2E);

const kButtonElevation = 2.0;
const kListTileLeftPadding = 10.0;

const kModalBorderRadius = 20.0;
const kButtonPadding = EdgeInsets.symmetric(vertical: 10);
final kButtonBorderRadius = BorderRadius.circular(15.0);
const kDisabledOpacity = 0.4;

const SystemUiOverlayStyle kOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: kPrimaryColor,
  systemNavigationBarIconBrightness: Brightness.light,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
);

const SystemUiOverlayStyle kOverlayDarkStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: kPrimaryColor,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
);

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
  color: kPrimaryColor,
  fontSize: 22.0,
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

final inputDecorationThemeData = InputDecorationTheme(
  border: InputBorder.none,
  errorStyle: bodySmall.copyWith(color: kErrorColor),
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: const MaterialStatePropertyAll(kButtonElevation),
    padding: const MaterialStatePropertyAll(kButtonPadding),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
    ),
    textStyle: const MaterialStatePropertyAll(bodyMedium),
  ),
);

final checkBoxThemeData = CheckboxThemeData(
  checkColor: MaterialStateProperty.all(Colors.white),
  fillColor: MaterialStateProperty.all(kPrimaryColor),
  side: const BorderSide(color: kPrimaryColor, width: 1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  ),
);

const listTileThemeData = ListTileThemeData(
  contentPadding: EdgeInsets.only(left: kListTileLeftPadding),
);

const textSelectionThemeData = TextSelectionThemeData(
  cursorColor: kPrimaryColor,
);
