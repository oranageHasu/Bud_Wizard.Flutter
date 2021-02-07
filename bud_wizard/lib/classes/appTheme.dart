import 'package:bud_wizard/classes/enumerations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Global singleton that represents the current App Theme state
DankTheme currentTheme = DankTheme();

class DankTheme with ChangeNotifier {
  static bool _isDark = true;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void setLightTheme() {
    _isDark = false;
    notifyListeners();
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

// Dark Theme
ThemeData dankDarkTheme = ThemeData(
  primaryColor: appBaseColor,
  accentColor: appBaseColor,
  scaffoldBackgroundColor: appDarkBackgroundColor,
  backgroundColor: appDarkBackgroundColor,
  dialogBackgroundColor: appDarkBackgroundColor,
  canvasColor: Colors.transparent,
  cardColor: appDarkBackgroundColor,
  dividerColor: appDarkBackgroundColor,
  unselectedWidgetColor: appDarkUnselectedColor,
  focusColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.black.withOpacity(0.3),
  errorColor: appErrorColor,

  indicatorColor: Colors.purple,
  selectedRowColor: Colors.purple,

  // Text theming
  textTheme: Typography.blackCupertino.apply(
    bodyColor: appBaseWhiteTextColor,
    displayColor: Colors.pink,
  ),

  // Text selection themeing
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: appBaseColor.withOpacity(0.5),
    selectionColor: appBaseColor.withOpacity(0.5),
    selectionHandleColor: appBaseColor.withOpacity(0.5),
  ),
);

// Light Theme
ThemeData dankLightTheme = ThemeData(
  primaryColor: appBaseColor,
  accentColor: appBaseColor,
  scaffoldBackgroundColor: appLightBackgroundColor,
  backgroundColor: appLightBackgroundColor,
  dialogBackgroundColor: appLightBackgroundColor,
  canvasColor: Colors.transparent,
  cardColor: appLightBackgroundColor,
  dividerColor: appLightBackgroundColor,
  unselectedWidgetColor: appLightUnselectedColor,
  focusColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.black.withOpacity(0.3),
  errorColor: appErrorColor,

  // Text selection themeing
  textTheme: Typography.blackCupertino.apply(
    bodyColor: appBaseBlackTextColor,
    displayColor: Colors.pink,
  ),

  // Text selection themeing
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: appBaseBlackTextColor.withOpacity(0.8),
    selectionColor: appBaseColor.withOpacity(0.5),
    selectionHandleColor: appBaseBlackTextColor.withOpacity(0.8),
  ),
);

//#region App Color Theme
// The App's base color
MaterialColor appBaseColor =
    MaterialColor(appPrimaryColor.value, appBaseColorOpacity);
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

// General "Base App Theme Colors" (e.g. Backgrounds, focal colors, etc. used throughout the app)
const Color appPrimaryColor = Color.fromRGBO(71, 196, 157, 1.0);

// Dark Theme colors
const Color appDarkSecondaryColor = Color.fromRGBO(54, 57, 63, 1.0);
const Color appDarkTertiaryColor = Color.fromRGBO(47, 49, 54, 1.0);
const Color appDarkBackgroundColor = Color.fromRGBO(32, 34, 37, 1.0);
const Color appDarkContentBackgroundColor = Color.fromRGBO(11, 12, 16, 1.0);
const Color appDarkUnselectedColor = Color.fromRGBO(252, 252, 252, 0.3);

// Light Theme colors
const Color appLightSecondaryColor = appBaseWhiteTextColor;
const Color appLightTertiaryColor = Color.fromRGBO(240, 240, 240, 1.0);
const Color appLightBackgroundColor = appBaseWhiteTextColor;
const Color appLightContentBackgroundColor = Color.fromRGBO(11, 12, 16, 1.0);
const Color appLightUnselectedColor = Color.fromRGBO(102, 102, 102, 0.6);

// Other App Theme Colors (e.g. Fonts, Events, special Widgets, etc.)
const Color appBaseWhiteTextColor = Color.fromRGBO(252, 252, 252, 1.0);
const Color appBaseBlackTextColor = Color.fromRGBO(31, 31, 31, 1.0);
const Color appHintTextColor = Color.fromRGBO(140, 140, 140, 0.8);
const Color appSuccessColor = Color.fromRGBO(196, 250, 187, 1.0);
const Color appWarningColor = Color.fromRGBO(255, 140, 54, 0.6);
const Color appErrorColor = Color.fromRGBO(250, 70, 70, 1.0);
const Color appDropdownColor = Color.fromRGBO(81, 80, 82, 1);

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
const Color chartComplementaryColor1 = Color(0xFFc4476e);
const Color chartComplementaryColor2 = Color(0xFF476ec4);
const Color chartMonochromaticColor = Color(0xFF60ab93);

//#endregion
//#region App Font styles

final TextStyle appHeaderFontStyle = GoogleFonts.courgette(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const TextStyle appInputFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
);

const TextStyle appInputHintFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 14,
  color: appHintTextColor,
);

const TextStyle appInputLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20.0,
);

const TextStyle appInputCounterFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

final TextStyle appLabelHeaderFontStyle = GoogleFonts.nunito(
  fontSize: 30.0,
  color: appBaseColor,
);

const TextStyle appLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20.0,
);

final TextStyle appValueLabelFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  color: (currentTheme.currentTheme() == ThemeMode.dark)
      ? appDarkSecondaryColor
      : appLightSecondaryColor,
);

const TextStyle appButtonFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

const TextStyle appTooltipFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 13.0,
);

final TextStyle appErrorFontStyle = GoogleFonts.varelaRound(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: appErrorColor,
);

final TextStyle appPlantWeekFontStyle = GoogleFonts.itim(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

final TextStyle appPlantDetailStyle = GoogleFonts.itim(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
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

final TextStyle appInstructionHeaderFontStyle = GoogleFonts.architectsDaughter(
  fontSize: 25.0,
);

final TextStyle appInstructionLabelFontStyle = GoogleFonts.architectsDaughter(
  fontSize: 18.0,
);

//#endregion
//#region Theme Functions

Color getGrowthStateColor(GrowState growthState) {
  Color retval = appBaseWhiteTextColor;

  switch (growthState) {
    case GrowState.NotApplicable:
      retval = (currentTheme.currentTheme() == ThemeMode.dark)
          ? appDarkUnselectedColor
          : appLightUnselectedColor;
      break;
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
