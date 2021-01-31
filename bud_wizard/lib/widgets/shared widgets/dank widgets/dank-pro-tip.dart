import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-clickable-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankProTip extends StatelessWidget {
  final String proTipText;
  final VoidCallback onLearnMore;

  DankProTip({
    @required String proTipText,
    @required VoidCallback onLearnMore,
  })  : this.proTipText = proTipText,
        this.onLearnMore = onLearnMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DankLabel(
          displayText: 'PRO TIP:',
          textStyle: appLabelFontStyle.copyWith(
            fontSize: 12.0,
            color: appBaseColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        DankLabel(
          displayText: proTipText,
          textStyle: appLabelFontStyle.copyWith(
            fontSize: 12.0,
            color: appBorderUnselectedColor,
          ),
          padding: EdgeInsets.only(
            left: 5.0,
            right: 10.0,
          ),
        ),
        DankClickableLabel(
          displayText: 'Learn more',
          onTapped: onLearnMore,
          textStyle: appLabelFontStyle.copyWith(
            fontSize: 14.0,
            color: Colors.lightBlue,
          ),
        ),
      ],
    );
  }
}
