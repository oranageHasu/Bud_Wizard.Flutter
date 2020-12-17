import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankOperationPanel.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankIconButton extends StatefulWidget {
  final IconData iconData;
  final String tooltipText;
  final VoidCallback onPressed;
  final VoidCallback onHover;
  final VoidCallback onLostHover;
  final Function(Screen) isSelected;
  final Color color;
  final double iconSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final DankButtonType buttonType;
  final bool isDisabled;

  DankIconButton({
    @required IconData iconData,
    @required String tooltipText,
    @required double iconSize,
    VoidCallback onPressed,
    VoidCallback onHover,
    VoidCallback onLostHover,
    Function(Screen) isSelected,
    Color color = Colors.white,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    EdgeInsets margin = const EdgeInsets.all(0.0),
    bool isDisabled = false,
    DankButtonType buttonType = DankButtonType.Flat,
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
        this.buttonType = buttonType;

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
      );
}

class DankIconButtonState extends State<DankIconButton> {
  IconData iconData;
  String tooltipText;
  VoidCallback onPressed;
  VoidCallback onHover;
  VoidCallback onLostHover;
  Function(Screen) isSelected;
  Color color;
  double iconSize;
  EdgeInsets padding;
  EdgeInsets margin;
  DankButtonType buttonType;
  bool isDisabled;
  bool isHovered = false;
  bool isButtonSelected = false;

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
    // If the parent propogated a change, reflect it in this component
    DankOperationPanelState data = DankOperationPanel.of(context);

    if (isSelected != null) {
      setState(() {
        isButtonSelected = isSelected(data.currentScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: tooltipText,
      displayTooltip: isHovered,
      child: MouseRegion(
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
          width: (isButtonSelected || isHovered) ? 65.0 : 55.0,
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
                )
              : FlatButton(
                  padding: EdgeInsets.all(18.0),
                  clipBehavior: Clip.hardEdge,
                  autofocus: true,
                  color: (isButtonSelected || isHovered)
                      ? appBaseColor
                      : appThirdColor,
                  textColor: Colors.white,
                  disabledTextColor: appBaseWhiteTextColor,
                  disabledColor: Colors.black.withOpacity(0.3),
                  hoverColor: Colors.transparent,
                  shape: (isButtonSelected || isHovered)
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                      : StadiumBorder(),
                  onPressed: (isDisabled) ? null : onPressed,
                  child: new Icon(
                    iconData,
                    color: (isButtonSelected || isHovered)
                        ? color
                        : color.withOpacity(0.5),
                    size: iconSize,
                  ),
                ),
        ),
      ),
    );
  }
}
