import 'package:bud_wizard/classes/appTheme.dart';
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
              color: appBaseWhiteTextColor.withOpacity(0.6),
            ),
            width: 200.0,
            padding: EdgeInsets.only(
              left: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}
