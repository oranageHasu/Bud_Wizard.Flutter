import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankShield extends StatelessWidget {
  final String displayText;
  final String statusText;
  final DankShieldStatus status;
  final EdgeInsets padding;
  final VoidCallback clicked;
  final String tooltipText;

  DankShield({
    @required String displayText,
    @required String statusText,
    @required DankShieldStatus status,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    VoidCallback clicked,
    @required String tooltipText,
  })  : this.displayText = displayText,
        this.statusText = statusText,
        this.status = status,
        this.padding = padding,
        this.clicked = clicked,
        this.tooltipText = tooltipText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (clicked != null) {
          clicked();
        }
      },
      mouseCursor: (clicked != null)
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: DankTooltip(
        tooltipText: tooltipText,
        displayTooltip: false,
        child: Container(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 30.0,
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: appTertiaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        displayText,
                        style: appLabelFontStyle.copyWith(
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: convertStatusToColor(),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        statusText,
                        style: appLabelFontStyle.copyWith(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color convertStatusToColor() {
    Color retval;

    switch (status) {
      case DankShieldStatus.Success:
        retval = appSuccessColor;
        break;
      case DankShieldStatus.Warning:
        retval = appWarningColor;
        break;
      case DankShieldStatus.Error:
        retval = appErrorColor;
        break;
    }

    return retval;
  }
}
