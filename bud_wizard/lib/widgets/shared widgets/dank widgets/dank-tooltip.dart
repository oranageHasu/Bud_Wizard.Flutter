import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class DankTooltip extends StatelessWidget {
  final String tooltipText;
  final Widget child;
  final bool displayTooltip;

  DankTooltip({
    @required Widget child,
    @required bool displayTooltip,
    String tooltipText,
  })  : this.tooltipText = tooltipText,
        this.displayTooltip = displayTooltip,
        this.child = child;

  @override
  Widget build(BuildContext context) {
    return SimpleTooltip(
      animationDuration: Duration(milliseconds: 0),
      show: displayTooltip,
      tooltipDirection: TooltipDirection.right,
      content: Container(
        child: DankLabel(
          displayText: tooltipText,
          textStyle: appTooltipFontStyle.copyWith(color: appBaseWhiteTextColor),
        ),
      ),
      backgroundColor: appBaseContentBackgroundColor,
      borderRadius: 5.0,
      child: child,
      ballonPadding: EdgeInsets.all(5.0),
      borderWidth: 0.0,
      arrowLength: 25,
      arrowTipDistance: 12,
    );
  }
}
