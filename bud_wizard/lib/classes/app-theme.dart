import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//#region App Color Theme

// The App's base color
MaterialColor appBaseColor = MaterialColor(0xFF86C232, appBaseColorOpacity);
Map<int, Color> appBaseColorOpacity = {
  50: Color.fromRGBO(0, 104, 54, .1),
  100: Color.fromRGBO(0, 104, 54, .2),
  200: Color.fromRGBO(0, 104, 54, .3),
  300: Color.fromRGBO(0, 104, 54, .4),
  400: Color.fromRGBO(0, 104, 54, .5),
  500: Color.fromRGBO(0, 104, 54, .6),
  600: Color.fromRGBO(0, 104, 54, .7),
  700: Color.fromRGBO(0, 104, 54, .8),
  800: Color.fromRGBO(0, 104, 54, .9),
  900: Color.fromRGBO(0, 104, 54, 1),
};

// The App's base background color
MaterialColor appBaseBackgroundColor =
    MaterialColor(0xFF222629, appBaseBackgroundColorOpacity);
Map<int, Color> appBaseBackgroundColorOpacity = {
  50: Color.fromRGBO(31, 40, 51, .1),
  100: Color.fromRGBO(31, 40, 51, .2),
  200: Color.fromRGBO(31, 40, 51, .3),
  300: Color.fromRGBO(31, 40, 51, .4),
  400: Color.fromRGBO(31, 40, 51, .5),
  500: Color.fromRGBO(31, 40, 51, .6),
  600: Color.fromRGBO(31, 40, 51, .7),
  700: Color.fromRGBO(31, 40, 51, .8),
  800: Color.fromRGBO(31, 40, 51, .9),
  900: Color.fromRGBO(31, 40, 51, 1),
};

// The App's base background color
MaterialColor appBaseContentBackgroundColor =
    MaterialColor(0xFF222629, appBaseContentBackgroundColorOpacity);
Map<int, Color> appBaseContentBackgroundColorOpacity = {
  50: Color.fromRGBO(11, 12, 16, .1),
  100: Color.fromRGBO(11, 12, 16, .2),
  200: Color.fromRGBO(11, 12, 16, .3),
  300: Color.fromRGBO(11, 12, 16, .4),
  400: Color.fromRGBO(11, 12, 16, .5),
  500: Color.fromRGBO(11, 12, 16, .6),
  600: Color.fromRGBO(11, 12, 16, .7),
  700: Color.fromRGBO(11, 12, 16, .8),
  800: Color.fromRGBO(11, 12, 16, .9),
  900: Color.fromRGBO(11, 12, 16, 1),
};

// The App's base white text color
MaterialColor appBaseWhiteTextColor =
    MaterialColor(0xFFfcfcfc, appBaseWhiteTextColorOpacity);
Map<int, Color> appBaseWhiteTextColorOpacity = {
  50: Color.fromRGBO(252, 252, 252, .1),
  100: Color.fromRGBO(252, 252, 252, .2),
  200: Color.fromRGBO(252, 252, 252, 3),
  300: Color.fromRGBO(252, 252, 252, .4),
  400: Color.fromRGBO(252, 252, 252, .5),
  500: Color.fromRGBO(252, 252, 252, .6),
  600: Color.fromRGBO(252, 252, 252, .7),
  700: Color.fromRGBO(252, 252, 252, .8),
  800: Color.fromRGBO(252, 252, 252, .9),
  900: Color.fromRGBO(252, 252, 252, 1),
};

// The App's 2nd color
MaterialColor appSecondColor = MaterialColor(0xFF6B6E70, appSecondColorOpacity);
Map<int, Color> appSecondColorOpacity = {
  50: Color.fromRGBO(252, 252, 252, .1),
  100: Color.fromRGBO(252, 252, 252, .2),
  200: Color.fromRGBO(252, 252, 252, 3),
  300: Color.fromRGBO(252, 252, 252, .4),
  400: Color.fromRGBO(252, 252, 252, .5),
  500: Color.fromRGBO(252, 252, 252, .6),
  600: Color.fromRGBO(252, 252, 252, .7),
  700: Color.fromRGBO(252, 252, 252, .8),
  800: Color.fromRGBO(252, 252, 252, .9),
  900: Color.fromRGBO(252, 252, 252, 1),
};

// The App's 3rd color
MaterialColor appThirdColor = MaterialColor(0xFF6B6E70, appThirdColorOpacity);
Map<int, Color> appThirdColorOpacity = {
  50: Color.fromRGBO(252, 252, 252, .1),
  100: Color.fromRGBO(252, 252, 252, .2),
  200: Color.fromRGBO(252, 252, 252, 3),
  300: Color.fromRGBO(252, 252, 252, .4),
  400: Color.fromRGBO(252, 252, 252, .5),
  500: Color.fromRGBO(252, 252, 252, .6),
  600: Color.fromRGBO(252, 252, 252, .7),
  700: Color.fromRGBO(252, 252, 252, .8),
  800: Color.fromRGBO(252, 252, 252, .9),
  900: Color.fromRGBO(252, 252, 252, 1),
};

//#endregion
//#region App Font styles

final TextStyle appHeaderFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 30.0,
  color: appBaseWhiteTextColor.shade700,
);

final TextStyle appInputFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20.0,
  color: appBaseWhiteTextColor.shade700,
);

final TextStyle appInputHintFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.0,
  color: appBaseWhiteTextColor.shade700,
);

final TextStyle appLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.0,
  color: appBaseWhiteTextColor.shade700,
);

final TextStyle appErrorFontStyle =
    GoogleFonts.varelaRound(fontSize: 15.0, color: Colors.redAccent[200]);

//#endregion
