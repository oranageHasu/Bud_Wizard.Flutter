import 'package:bud_wizard/classes/appTheme.dart';
import 'package:flutter/material.dart';

class DankBasicTooltip extends StatelessWidget {
  final String tooltipText;
  final Widget child;

  DankBasicTooltip({
    @required String tooltipText,
    @required Widget child,
  })  : this.tooltipText = tooltipText,
        this.child = child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: (tooltipText != null) ? tooltipText : 'Disabled',
      child: child,
      textStyle: appInputFontStyle.copyWith(
        fontSize: 12.0,
        color: appBaseWhiteTextColor,
      ),
      decoration: BoxDecoration(
        color: appDarkBackgroundColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: appBaseColor.withOpacity(0.1),
            blurRadius: 25.0,
            spreadRadius: 15.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(7.5),
      verticalOffset: 30.0,
    );
  }
}
