import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class PlantMenuItem extends StatefulWidget {
  final String displayText;
  final String tooltipText;
  final bool isSelected;
  final Function(PlantOperation) onSelected;
  final PlantOperation opType;
  final int unreadNotificationCount;
  final bool displayNotificationAsAlert;

  PlantMenuItem({
    @required String displayText,
    @required String tooltipText,
    @required Function(PlantOperation) onSelected,
    @required PlantOperation opType,
    bool isSelected = false,
    int unreadNotificationCount = 0,
    bool displayNotificationAsAlert = false,
  })  : this.displayText = displayText,
        this.tooltipText = tooltipText,
        this.onSelected = onSelected,
        this.opType = opType,
        this.isSelected = isSelected,
        this.unreadNotificationCount = unreadNotificationCount,
        this.displayNotificationAsAlert = displayNotificationAsAlert;

  @override
  _PlantMenuItemState createState() => _PlantMenuItemState();
}

class _PlantMenuItemState extends State<PlantMenuItem> {
  bool _isHovered = false;

  @override
  void didUpdateWidget(PlantMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: widget.tooltipText,
      displayTooltip: _isHovered,
      tooltipDirection: TooltipDirection.down,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (value) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            _isHovered = false;
          });
        },
        child: InkWell(
          onTap: () => {
            if (widget.onSelected != null) {widget.onSelected(widget.opType)}
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    DankLabel(
                      displayText: widget.displayText,
                      textStyle: (widget.isSelected || _isHovered)
                          ? appLabelFontStyle
                          : appLabelFontStyle.copyWith(
                              color: appHintTextColor,
                            ),
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right:
                            (widget.unreadNotificationCount == 0) ? 20.0 : 50.0,
                        bottom: 2.0,
                        top: 15.0,
                      ),
                    ),
                    if (widget.unreadNotificationCount > 0)
                      notificationBadge(widget.displayNotificationAsAlert),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 3.0,
                          margin: EdgeInsets.only(
                            left: 15,
                            right: (widget.unreadNotificationCount == 0)
                                ? 15.0
                                : 45.0,
                          ),
                          color: (widget.isSelected)
                              ? appBaseColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationBadge(bool isAlert) {
    return Positioned(
      right: 25,
      top: 0,
      child: Container(
        //constraints: BoxConstraints(minWidth: 25.0),
        width: 25.0,
        decoration: new BoxDecoration(
          color: (widget.isSelected || _isHovered)
              ? appBaseColor
              : appBaseColor.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: DankLabel(
            displayText:
                (isAlert) ? '!' : widget.unreadNotificationCount.toString(),
            textStyle: determineTextStyle(),
            padding: EdgeInsets.all(5),
          ),
        ),
      ),
    );
  }

  TextStyle determineTextStyle() {
    TextStyle retval;
    double fontSize = 14.0;

    if (widget.displayNotificationAsAlert) {
      fontSize = 18.0;
    }

    retval = appLabelFontStyle.copyWith(
      color: appHintTextColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    if (widget.isSelected || _isHovered) {
      retval = retval.copyWith(
        color: appBaseWhiteTextColor,
        fontSize: fontSize,
      );
    }

    return retval;
  }
}
