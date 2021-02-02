import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class DankTooltip extends StatelessWidget {
  final String tooltipText;
  final Widget child;
  final bool displayTooltip;
  final TooltipDirection tooltipDirection;

  DankTooltip({
    @required Widget child,
    @required bool displayTooltip,
    String tooltipText,
    TooltipDirection tooltipDirection = TooltipDirection.right,
  })  : this.tooltipText = tooltipText,
        this.displayTooltip = displayTooltip,
        this.child = child,
        this.tooltipDirection = tooltipDirection;

  @override
  Widget build(BuildContext context) {
    return SimpleTooltip(
      animationDuration: Duration(milliseconds: 0),
      show: displayTooltip,
      tooltipDirection: tooltipDirection,
      content: Container(
        child: DankLabel(
          displayText: tooltipText,
          textStyle: appTooltipFontStyle.copyWith(color: appBaseWhiteTextColor),
        ),
      ),
      backgroundColor: appBaseContentBackgroundColor,
      borderRadius: 5.0,
      child: child,
      ballonPadding: EdgeInsets.all(0.0),
      borderWidth: 0.0,
      arrowLength: 10,
      arrowTipDistance: 3,
      customShadows: [
        BoxShadow(
          color: appBaseColor.withOpacity(0.1),
          blurRadius: 25.0,
          spreadRadius: 15.0,
        ),
      ],
    );
  }
}
