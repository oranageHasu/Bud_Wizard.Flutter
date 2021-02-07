import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicTooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankBasicIconButton extends StatefulWidget {
  final IconData iconData;
  final String tooltipText;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
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

  DankBasicIconButton({
    @required IconData iconData,
    @required String tooltipText,
    @required double iconSize,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    bool isSelected = false,
    Color color,
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
  _DankBasicIconButtonState createState() => _DankBasicIconButtonState();
}

class _DankBasicIconButtonState extends State<DankBasicIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return DankBasicTooltip(
      tooltipText: (widget.isDisabled) ? null : widget.tooltipText,
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
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
          child: _buildButtonByType(),
        ),
      ),
    );
  }

  Widget _outlineButton() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: (!widget.isDisabled)
              ? (_isHovered)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.8)
              : (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appDarkUnselectedColor
                  : appLightUnselectedColor,
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: (widget.isSelected || _isHovered && !widget.isDisabled)
                ? Theme.of(context).primaryColor.withOpacity(0.5)
                : Colors.transparent,
            blurRadius: 35.0,
          ),
        ],
      ),
      child: _iconButton(),
    );
  }

  Widget _flatButton() {
    return FlatButton(
      padding: EdgeInsets.all(18.0),
      clipBehavior: Clip.hardEdge,
      autofocus: true,
      color: (widget.isSelected || _isHovered)
          ? appBaseColor
          : (currentTheme.currentTheme() == ThemeMode.dark)
              ? appDarkTertiaryColor
              : Colors.black.withOpacity(0.05),
      textColor: Colors.white,
      disabledTextColor: appBaseWhiteTextColor,
      disabledColor: Colors.black.withOpacity(0.3),
      hoverColor: Colors.transparent,
      shape: CircleBorder(
        side: BorderSide(
          width: 1.0,
        ),
      ),
      onPressed: (widget.isDisabled) ? null : widget.onPressed,
      onLongPress: (widget.isDisabled) ? null : widget.onLongPress,
      child: Icon(
        widget.iconData,
        color: (widget.isSelected || _isHovered)
            ? widget.color.withOpacity(0.9)
            : (currentTheme.currentTheme() == ThemeMode.dark)
                ? widget.color.withOpacity(0.6)
                : appBaseBlackTextColor.withOpacity(0.6),
        size: widget.iconSize,
      ),
      mouseCursor: SystemMouseCursors.click,
    );
  }

  Widget _iconButton() {
    return IconButton(
      icon: Icon(
        widget.iconData,
        color: _getIconColor(),
        size: widget.iconSize,
      ),
      disabledColor: (currentTheme.currentTheme() == ThemeMode.dark)
          ? appDarkUnselectedColor
          : appLightUnselectedColor,
      padding: EdgeInsets.all(0.0),
      splashRadius: 1,
      hoverColor: (widget.showClickInteraction)
          ? widget.hoverColor.withOpacity(0.5)
          : Colors.transparent,
      splashColor: (widget.showClickInteraction)
          ? widget.hoverColor.withOpacity(0.5)
          : Colors.transparent,
      highlightColor: (widget.showClickInteraction)
          ? widget.hoverColor.withOpacity(0.5)
          : Colors.transparent,
      onPressed: (widget.isDisabled) ? null : widget.onPressed,
      mouseCursor: SystemMouseCursors.click,
    );
  }

  Widget _buildButtonByType() {
    Widget retval;

    switch (widget.buttonType) {
      case DankButtonType.Flat:
        retval = _flatButton();
        break;
      case DankButtonType.Outline:
        retval = _outlineButton();
        break;
      case DankButtonType.Icon:
        retval = _iconButton();
        break;
    }

    return retval;
  }

  Color _getIconColor() {
    Color retval = (currentTheme.currentTheme() == ThemeMode.dark)
        ? appDarkUnselectedColor
        : appLightUnselectedColor;

    if (!widget.isDisabled) {
      retval = (widget.isSelected || _isHovered)
          ? (widget.color != null)
              ? widget.color
              : Theme.of(context).primaryColor
          : (widget.color != null)
              ? widget.color.withOpacity(0.5)
              : Theme.of(context).primaryColor.withOpacity(0.5);
    }

    return retval;
  }
}
