import 'package:bud_wizard/classes/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//#region App Color Theme
// The App's base color
MaterialColor appBaseColor = MaterialColor(0xFF47c49d, appBaseColorOpacity);
Map<int, Color> appBaseColorOpacity = {
  50: appPrimaryColor.withOpacity(0.1),
  100: appPrimaryColor.withOpacity(0.2),
  200: appPrimaryColor.withOpacity(0.3),
  300: appPrimaryColor.withOpacity(0.4),
  400: appPrimaryColor.withOpacity(0.5),
  500: appPrimaryColor.withOpacity(0.6),
  600: appPrimaryColor.withOpacity(0.7),
  700: appPrimaryColor.withOpacity(0.8),
  800: appPrimaryColor.withOpacity(0.9),
  900: appPrimaryColor.withOpacity(1.0),
};

// The App's base background color
MaterialColor appBaseBackgroundColor =
    MaterialColor(0xFF202225, appBaseBackgroundColorOpacity);
Map<int, Color> appBaseBackgroundColorOpacity = {
  50: appBackgroundColor.withOpacity(0.1),
  100: appBackgroundColor.withOpacity(0.2),
  200: appBackgroundColor.withOpacity(0.3),
  300: appBackgroundColor.withOpacity(0.4),
  400: appBackgroundColor.withOpacity(0.5),
  500: appBackgroundColor.withOpacity(0.6),
  600: appBackgroundColor.withOpacity(0.7),
  700: appBackgroundColor.withOpacity(0.8),
  800: appBackgroundColor.withOpacity(0.9),
  900: appBackgroundColor.withOpacity(1),
};

// The App's base background color
MaterialColor appBaseContentBackgroundColor =
    MaterialColor(0xFF0B0C10, appBaseContentBackgroundColorOpacity);
Map<int, Color> appBaseContentBackgroundColorOpacity = {
  50: appContentBackgroundColor.withOpacity(0.1),
  100: appContentBackgroundColor.withOpacity(0.2),
  200: appContentBackgroundColor.withOpacity(0.3),
  300: appContentBackgroundColor.withOpacity(0.4),
  400: appContentBackgroundColor.withOpacity(0.5),
  500: appContentBackgroundColor.withOpacity(0.6),
  600: appContentBackgroundColor.withOpacity(0.7),
  700: appContentBackgroundColor.withOpacity(0.8),
  800: appContentBackgroundColor.withOpacity(0.9),
  900: appContentBackgroundColor.withOpacity(1),
};

// The App's 2nd color
MaterialColor appSecondColor = MaterialColor(0xFF36393F, appSecondColorOpacity);
Map<int, Color> appSecondColorOpacity = {
  50: appSecondaryColor.withOpacity(0.1),
  100: appSecondaryColor.withOpacity(0.2),
  200: appSecondaryColor.withOpacity(0.3),
  300: appSecondaryColor.withOpacity(0.4),
  400: appSecondaryColor.withOpacity(0.5),
  500: appSecondaryColor.withOpacity(0.6),
  600: appSecondaryColor.withOpacity(0.7),
  700: appSecondaryColor.withOpacity(0.8),
  800: appSecondaryColor.withOpacity(0.9),
  900: appSecondaryColor.withOpacity(1),
};

// The App's 3rd color
MaterialColor appThirdColor = MaterialColor(0xFF2F3136, appThirdColorOpacity);
Map<int, Color> appThirdColorOpacity = {
  50: appTertiaryColor.withOpacity(0.1),
  100: appTertiaryColor.withOpacity(0.2),
  200: appTertiaryColor.withOpacity(0.3),
  300: appTertiaryColor.withOpacity(0.4),
  400: appTertiaryColor.withOpacity(0.5),
  500: appTertiaryColor.withOpacity(0.6),
  600: appTertiaryColor.withOpacity(0.7),
  700: appTertiaryColor.withOpacity(0.8),
  800: appTertiaryColor.withOpacity(0.9),
  900: appTertiaryColor.withOpacity(1),
};

// General "Base App Theme Colors" (e.g. Backgrounds, focal colors, etc. used throughout the app)
const Color appPrimaryColor = Color.fromRGBO(71, 196, 157, 1.0);
const Color appSecondaryColor = Color.fromRGBO(54, 57, 63, 1.0);
const Color appTertiaryColor = Color.fromRGBO(47, 49, 54, 1.0);
const Color appBackgroundColor = Color.fromRGBO(32, 34, 37, 1.0);
const Color appContentBackgroundColor = Color.fromRGBO(11, 12, 16, 1.0);

// Other App Theme Colors (e.g. Fonts, Events, sepcial Widgets, etc.)
const Color appBaseWhiteTextColor = Color.fromRGBO(252, 252, 252, 1.0);
const Color appHintTextColor = Color.fromRGBO(140, 140, 140, 0.8);
const Color appSuccessColor = Color.fromRGBO(196, 250, 187, 1.0);
const Color appWarningColor = Color.fromRGBO(255, 140, 54, 0.6);
const Color appErrorColor = Color.fromRGBO(250, 127, 127, 1.0);
const Color appDropdownColor = Color.fromRGBO(81, 80, 82, 1);
const Color appBorderUnselectedColor = Color.fromRGBO(252, 252, 252, 0.3);

// Grow related colors
const Color growGerminationColor = Color.fromRGBO(71, 53, 0, 1.0);
const Color growVegetativeColor = Color.fromRGBO(0, 184, 70, 1.0);
const Color growFloweringColor = Color.fromRGBO(222, 203, 0, 1.0);
const Color growDryingColor = Color.fromRGBO(222, 170, 0, 1.0);
const Color growCuringColor = Color.fromRGBO(222, 93, 0, 1.0);

// Chart colors
const Color chartLinesColor = Color(0xff37434d);
const Color chartAvgUserColor = Color(0xFFc45e47);
const Color chartAvgColor = Color(0xFFc49c47);

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

final TextStyle appChartYAxisFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: appBaseWhiteTextColor.withOpacity(0.6),
);

final TextStyle appChartXAxisFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
  color: appBaseWhiteTextColor.withOpacity(0.6),
);

//#endregion
//#region Theme Functions

Color getGrowthStateColor(GrowState growthState) {
  Color retval = appBaseWhiteTextColor;

  switch (growthState) {
    case GrowState.Germination:
      retval = growGerminationColor;
      break;
    case GrowState.Vegetative:
      retval = growVegetativeColor;
      break;
    case GrowState.Flowering:
      retval = growFloweringColor;
      break;
    case GrowState.Drying:
      retval = growDryingColor;
      break;
    case GrowState.Curing:
      retval = growCuringColor;
      break;
  }

  return retval;
}

//#endregion
