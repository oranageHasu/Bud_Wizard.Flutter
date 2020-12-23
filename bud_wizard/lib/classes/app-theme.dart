import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//#region App Color Theme

// The App's base color
MaterialColor appBaseColor = MaterialColor(0xFF47c49d, appBaseColorOpacity);
Map<int, Color> appBaseColorOpacity = {
  50: Color.fromRGBO(102, 252, 241, .1),
  100: Color.fromRGBO(102, 252, 241, .2),
  200: Color.fromRGBO(102, 252, 241, .3),
  300: Color.fromRGBO(102, 252, 241, .4),
  400: Color.fromRGBO(102, 252, 241, .5),
  500: Color.fromRGBO(102, 252, 241, .6),
  600: Color.fromRGBO(102, 252, 241, .7),
  700: Color.fromRGBO(102, 252, 241, .8),
  800: Color.fromRGBO(102, 252, 241, .9),
  900: Color.fromRGBO(102, 252, 241, 1),
};

// The App's base background color
MaterialColor appBaseBackgroundColor =
    MaterialColor(0xFF202225, appBaseBackgroundColorOpacity);
Map<int, Color> appBaseBackgroundColorOpacity = {
  50: Color.fromRGBO(55, 54, 153, .1),
  100: Color.fromRGBO(55, 54, 153, .2),
  200: Color.fromRGBO(55, 54, 153, .3),
  300: Color.fromRGBO(55, 54, 153, .4),
  400: Color.fromRGBO(55, 54, 153, .5),
  500: Color.fromRGBO(55, 54, 153, .6),
  600: Color.fromRGBO(55, 54, 153, .7),
  700: Color.fromRGBO(55, 54, 153, .8),
  800: Color.fromRGBO(55, 54, 153, .9),
  900: Color.fromRGBO(55, 54, 153, 1),
};

// The App's base background color
MaterialColor appBaseContentBackgroundColor =
    MaterialColor(0xFF0B0C10, appBaseContentBackgroundColorOpacity);
Map<int, Color> appBaseContentBackgroundColorOpacity = {
  50: Color.fromRGBO(55, 54, 153, .1),
  100: Color.fromRGBO(55, 54, 153, .2),
  200: Color.fromRGBO(55, 54, 153, .3),
  300: Color.fromRGBO(55, 54, 153, .4),
  400: Color.fromRGBO(55, 54, 153, .5),
  500: Color.fromRGBO(55, 54, 153, .6),
  600: Color.fromRGBO(55, 54, 153, .7),
  700: Color.fromRGBO(55, 54, 153, .8),
  800: Color.fromRGBO(55, 54, 153, .9),
  900: Color.fromRGBO(55, 54, 153, 1),
};

// The App's 2nd color
MaterialColor appSecondColor = MaterialColor(0xFF36393F, appSecondColorOpacity);
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
MaterialColor appThirdColor = MaterialColor(0xFF2F3136, appThirdColorOpacity);
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

const Color appBaseWhiteTextColor = Color.fromRGBO(252, 252, 252, 1.0);
const Color appHintTextColor = Color.fromRGBO(140, 140, 140, 0.8);
const Color appSuccessColor = Color.fromRGBO(120, 222, 2, 0.6);
const Color appWarningColor = Color.fromRGBO(255, 140, 54, 0.6);
const Color appErrorColor = Color.fromRGBO(245, 66, 66, 0.6);
const Color appDropdownColor = Color.fromRGBO(81, 80, 82, 1);
const Color appBorderUnselectedColor = Color.fromRGBO(252, 252, 252, 0.3);

// Grow related colors
const Color growGerminationColor = Color.fromRGBO(71, 53, 0, 1.0);
const Color growVegetativeColor = Color.fromRGBO(0, 184, 70, 1.0);
const Color growFloweringColor = Color.fromRGBO(222, 203, 0, 1.0);
const Color growDryingColor = Color.fromRGBO(222, 170, 0, 1.0);
const Color growCuringColor = Color.fromRGBO(222, 93, 0, 1.0);

//#endregion
//#region App Font styles

final TextStyle appHeaderFontStyle = GoogleFonts.courgette(
  fontSize: 50.0,
  color: appBaseWhiteTextColor,
  fontWeight: FontWeight.bold,
);

const TextStyle appInputFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  color: appBaseWhiteTextColor,
);

const TextStyle appInputHintFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 14,
  color: appHintTextColor,
);

const TextStyle appInputLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20.0,
  color: appBaseWhiteTextColor,
);

const TextStyle appInputCounterFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: appBaseWhiteTextColor,
);

final TextStyle appLabelHeaderFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 30.0,
  color: appBaseColor,
);

const TextStyle appLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20.0,
  color: appBaseWhiteTextColor,
);

final TextStyle appValueLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  color: appSecondColor,
);

const TextStyle appButtonFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

const TextStyle appTooltipFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 13.0,
  color: appBaseWhiteTextColor,
);

final TextStyle appErrorFontStyle = GoogleFonts.varelaRound(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: appErrorColor,
);

final TextStyle appPlantWeekFontStyle = GoogleFonts.itim(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: appBaseWhiteTextColor,
);

final TextStyle appPlantDetailStyle = GoogleFonts.itim(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: appBaseWhiteTextColor,
);

//#endregion