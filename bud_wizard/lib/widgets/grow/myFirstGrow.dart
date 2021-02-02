import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFirstGrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: 2500,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DankLabel(
                  displayText: 'New to ',
                  textStyle: GoogleFonts.architectsDaughter(
                    fontSize: 25.0,
                    color: appBaseWhiteTextColor,
                  ),
                ),
                DankLabel(
                  displayText: 'Bud Wizard',
                  textStyle: GoogleFonts.architectsDaughter(
                    fontSize: 35.0,
                    color: appBaseColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DankLabel(
                  displayText: '?',
                  textStyle: GoogleFonts.architectsDaughter(
                    fontSize: 25.0,
                    color: appBaseWhiteTextColor,
                  ),
                ),
              ],
            ),
            isVisible: true,
          ),
          FadeIn(
            duration: 2500,
            delay: Duration(milliseconds: 1500),
            child: DankLabel(
              displayText: 'Let\'s start a grow together...',
              textStyle: GoogleFonts.architectsDaughter(
                fontSize: 35.0,
                color: appBaseWhiteTextColor,
              ),
              padding: EdgeInsets.only(top: 10.0),
            ),
            isVisible: true,
          ),
          FadeIn(
            duration: 2000,
            delay: Duration(milliseconds: 1500),
            child: DankButton(
              buttonType: DankButtonType.Flat,
              buttonText: 'Start Grow',
              textStyle: appLabelFontStyle.copyWith(fontSize: 25.0),
              borderRadius: 5.0,
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
                left: 35.0,
                right: 35.0,
              ),
              onPressed: () {
                GrowPage.of(context).startNewGrow();
              },
            ),
            isVisible: true,
          ),
        ],
      ),
    );
  }
}
