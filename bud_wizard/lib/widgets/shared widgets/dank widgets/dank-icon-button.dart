import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankIconButton extends StatefulWidget {
  final IconData iconData;
  final String tooltipText;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
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
  final bool displayTooltip;
  final Color outlineColor;
  final double outlineThickness;
  final Color hoverColor;
  final bool showClickInteraction;

  DankIconButton({
    @required IconData iconData,
    @required String tooltipText,
    @required double iconSize,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    VoidCallback onHover,
    VoidCallback onLostHover,
    bool isSelected = false,
    Color color = appBaseWhiteTextColor,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    EdgeInsets margin = const EdgeInsets.all(0.0),
    bool isDisabled = false,
    DankButtonType buttonType = DankButtonType.Flat,
    bool enableAnimation = false,
    bool displayTooltip = true,
    Color outlineColor = appPrimaryColor,
    double outlineThickness = 2.5,
    Color hoverColor = Colors.white,
    bool showClickInteraction = true,
  })  : this.iconData = iconData,
        this.tooltipText = tooltipText,
        this.onPressed = onPressed,
        this.onLongPress = onLongPress,
        this.onHover = onHover,
        this.onLostHover = onLostHover,
        this.isSelected = isSelected,
        this.color = color,
        this.iconSize = iconSize,
        this.padding = padding,
        this.margin = margin,
        this.isDisabled = isDisabled,
        this.buttonType = buttonType,
        this.enableAnimation = enableAnimation,
        this.displayTooltip = displayTooltip,
        this.outlineColor = outlineColor,
        this.outlineThickness = outlineThickness,
        this.hoverColor = hoverColor,
        this.showClickInteraction = showClickInteraction;

  @override
  DankIconButtonState createState() => DankIconButtonState();
}

class DankIconButtonState extends State<DankIconButton> {
  bool _isHovered = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: widget.tooltipText,
      displayTooltip: (widget.displayTooltip && _isHovered),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (value) {
          setState(() {
            _isHovered = true;
          });

          if (widget.onHover != null) {
            widget.onHover();
          }
        },
        onExit: (value) {
          setState(() {
            _isHovered = false;
          });

          if (widget.onLostHover != null) {
            widget.onLostHover();
          }
        },
        child: Container(
          margin: widget.margin,
          padding: widget.padding,
          height: 55.0,
          width: (widget.enableAnimation && (widget.isSelected || _isHovered))
              ? 65.0
              : 55.0,
          child: (widget.buttonType == DankButtonType.Outline)
              ? OutlineButton(
                  highlightedBorderColor: widget.outlineColor,
                  padding: EdgeInsets.all(15.0),
                  textColor: appBaseWhiteTextColor,
                  disabledBorderColor: Colors.black.withOpacity(0.3),
                  hoverColor: (widget.showClickInteraction)
                      ? widget.hoverColor.withOpacity(0.5)
                      : Colors.transparent,
                  borderSide: BorderSide(
                    color: widget.outlineColor,
                    width: widget.outlineThickness,
                  ),
                  splashColor: (widget.showClickInteraction)
                      ? widget.hoverColor.withOpacity(0.5)
                      : Colors.transparent,
                  highlightColor: (widget.showClickInteraction)
                      ? widget.hoverColor.withOpacity(0.5)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (widget.isDisabled) ? null : widget.onPressed,
                  onLongPress: (widget.isDisabled) ? null : widget.onLongPress,
                  child: new Icon(
                    widget.iconData,
                    color: (widget.isSelected || _isHovered)
                        ? widget.color
                        : widget.color.withOpacity(0.6),
                    size: widget.iconSize,
                  ),
                  mouseCursor: SystemMouseCursors.click,
                )
              : FlatButton(
                  padding: EdgeInsets.all(18.0),
                  clipBehavior: Clip.hardEdge,
                  autofocus: true,
                  color: (widget.isSelected || _isHovered)
                      ? appBaseColor
                      : appThirdColor,
                  textColor: Colors.white,
                  disabledTextColor: appBaseWhiteTextColor,
                  disabledColor: Colors.black.withOpacity(0.3),
                  hoverColor: Colors.transparent,
                  shape: (widget.enableAnimation &&
                          (widget.isSelected || _isHovered))
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                      : StadiumBorder(),
                  onPressed: (widget.isDisabled) ? null : widget.onPressed,
                  onLongPress: (widget.isDisabled) ? null : widget.onLongPress,
                  child: new Icon(
                    widget.iconData,
                    color: (widget.isSelected || _isHovered)
                        ? widget.color
                        : widget.color.withOpacity(0.5),
                    size: widget.iconSize,
                  ),
                  mouseCursor: SystemMouseCursors.click,
                ),
        ),
      ),
    );
  }
}
