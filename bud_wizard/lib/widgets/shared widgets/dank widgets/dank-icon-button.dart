import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankIconButton extends StatefulWidget {
  final IconData iconData;
  final String tooltipText;
  final VoidCallback onPressed;
  final VoidCallback onHover;
  final VoidCallback onLostHover;
  final bool isSelected;
  final Color color;
  final double iconSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final DankButtonType buttonType;
  final bool isDisabled;
  final bool enableAnimation;

  DankIconButton({
    @required IconData iconData,
    @required String tooltipText,
    @required double iconSize,
    VoidCallback onPressed,
    VoidCallback onHover,
    VoidCallback onLostHover,
    bool isSelected = false,
    Color color = Colors.white,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    EdgeInsets margin = const EdgeInsets.all(0.0),
    bool isDisabled = false,
    DankButtonType buttonType = DankButtonType.Flat,
    bool enableAnimation = false,
  })  : this.iconData = iconData,
        this.tooltipText = tooltipText,
        this.onPressed = onPressed,
        this.onHover = onHover,
        this.onLostHover = onLostHover,
        this.isSelected = isSelected,
        this.color = color,
        this.iconSize = iconSize,
        this.padding = padding,
        this.margin = margin,
        this.isDisabled = isDisabled,
        this.buttonType = buttonType,
        this.enableAnimation = enableAnimation;

  @override
  DankIconButtonState createState() => DankIconButtonState(
        this.iconData,
        this.tooltipText,
        this.onPressed,
        this.onHover,
        this.onLostHover,
        this.isSelected,
        this.color,
        this.iconSize,
        this.padding,
        this.margin,
        this.isDisabled,
        this.buttonType,
        this.enableAnimation,
      );
}

class DankIconButtonState extends State<DankIconButton> {
  IconData iconData;
  String tooltipText;
  VoidCallback onPressed;
  VoidCallback onHover;
  VoidCallback onLostHover;
  bool isSelected;
  Color color;
  double iconSize;
  EdgeInsets padding;
  EdgeInsets margin;
  DankButtonType buttonType;
  bool isDisabled;
  bool enableAnimation;
  bool isHovered = false;

  DankIconButtonState(
    this.iconData,
    this.tooltipText,
    this.onPressed,
    this.onHover,
    this.onLostHover,
    this.isSelected,
    this.color,
    this.iconSize,
    this.padding,
    this.margin,
    this.isDisabled,
    this.buttonType,
    this.enableAnimation,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DankIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: tooltipText,
      displayTooltip: isHovered,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (value) {
          setState(() {
            isHovered = true;
          });

          if (onHover != null) {
            onHover();
          }
        },
        onExit: (value) {
          setState(() {
            isHovered = false;
          });

          if (onLostHover != null) {
            onLostHover();
          }
        },
        child: Container(
          margin: margin,
          padding: padding,
          height: 55.0,
          width: (enableAnimation && (isSelected || isHovered)) ? 65.0 : 55.0,
          child: (buttonType == DankButtonType.Outline)
              ? OutlineButton(
                  padding: EdgeInsets.all(15.0),
                  textColor: appBaseWhiteTextColor,
                  disabledTextColor: appBaseWhiteTextColor,
                  disabledBorderColor: Colors.black.withOpacity(0.3),
                  hoverColor: Colors.white.withOpacity(0.1),
                  borderSide: BorderSide(color: appBaseColor, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (isDisabled) ? null : onPressed,
                  child: new Icon(
                    iconData,
                    color: color,
                    size: iconSize,
                  ),
                  mouseCursor: SystemMouseCursors.click,
                )
              : FlatButton(
                  padding: EdgeInsets.all(18.0),
                  clipBehavior: Clip.hardEdge,
                  autofocus: true,
                  color:
                      (isSelected || isHovered) ? appBaseColor : appThirdColor,
                  textColor: Colors.white,
                  disabledTextColor: appBaseWhiteTextColor,
                  disabledColor: Colors.black.withOpacity(0.3),
                  hoverColor: Colors.transparent,
                  shape: (enableAnimation && (isSelected || isHovered))
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                      : StadiumBorder(),
                  onPressed: (isDisabled) ? null : onPressed,
                  child: new Icon(
                    iconData,
                    color: (isSelected || isHovered)
                        ? color
                        : color.withOpacity(0.5),
                    size: iconSize,
                  ),
                  mouseCursor: SystemMouseCursors.click,
                ),
        ),
      ),
    );
  }
}