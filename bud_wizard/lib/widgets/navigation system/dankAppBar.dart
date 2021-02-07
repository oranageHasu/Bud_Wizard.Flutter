import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/environment.dart';
import 'package:bud_wizard/src/pubspec.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class DankAppBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      child: Row(
        children: [
          DankLabel(
            displayText: 'Bud Wizard',
            textStyle: appHeaderFontStyle.copyWith(
              fontSize: 17.0,
              color: (currentTheme.currentTheme() != ThemeMode.dark)
                  ? appBaseColor
                  : appBaseWhiteTextColor.withOpacity(0.6),
            ),
            width: 200.0,
            padding: EdgeInsets.only(
              left: 8.0,
            ),
          ),
          Expanded(child: SizedBox.shrink()),
          if (!isProduction())
            DankLabel(
              displayText: 'v',
              textStyle: appInputHintFontStyle.copyWith(
                color: (currentTheme.currentTheme() == ThemeMode.dark)
                    ? appBaseWhiteTextColor
                    : appBaseBlackTextColor,
              ),
              padding: EdgeInsets.only(right: 2.0),
            ),
          DankLabel(
            displayText: version,
            textStyle: appInputHintFontStyle.copyWith(
              color: appBaseColor,
            ),
            padding: EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
    );
  }
}
