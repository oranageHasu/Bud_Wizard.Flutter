import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final VoidCallback onHover;
  final VoidCallback onLostHover;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool isDisabled;
  final bool invertHoverColor;
  final DankButtonType buttonType;
  final Color textColor;
  final Color disabledTextColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color hoverColor;
  final double borderRadius;
  final DankFlatButtonType flatButtonShape;
  final TextStyle textStyle;
  final EdgeInsets textPadding;

  DankButton({
    @required buttonText,
    @required onPressed,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(0.0),
    bool isDisabled = false,
    bool invertHoverColor = false,
    DankButtonType buttonType = DankButtonType.Outline,
    Color textColor = appBaseWhiteTextColor,
    Color disabledTextColor = appBaseWhiteTextColor,
    Color backgroundColor = appPrimaryColor,
    Color borderColor = appPrimaryColor,
    Color hoverColor = const Color.fromRGBO(255, 255, 255, 0.1),
    double borderRadius = 0.0,
    DankFlatButtonType flatButtonShape = DankFlatButtonType.RoundedRectangle,
    TextStyle textStyle = appButtonFontStyle,
    EdgeInsets textPadding = const EdgeInsets.all(0),
    VoidCallback onLongPress,
    VoidCallback onHover,
    VoidCallback onLostHover,
  })  : this.buttonText = buttonText,
        this.onPressed = onPressed,
        this.onLongPress = onLongPress,
        this.onHover = onHover,
        this.onLostHover = onLostHover,
        this.margin = margin,
        this.padding = padding,
        this.isDisabled = isDisabled,
        this.invertHoverColor = invertHoverColor,
        this.buttonType = buttonType,
        this.textColor = textColor,
        this.disabledTextColor = disabledTextColor,
        this.backgroundColor = backgroundColor,
        this.borderColor = borderColor,
        this.hoverColor = hoverColor,
        this.borderRadius = borderRadius,
        this.flatButtonShape = flatButtonShape,
        this.textStyle = textStyle,
        this.textPadding = textPadding;

  @override
  _DankButtonState createState() => _DankButtonState();
}

class _DankButtonState extends State<DankButton> {
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
  void didUpdateWidget(DankButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
        child: (widget.buttonType == DankButtonType.Outline)
            ? OutlineButton(
                padding: widget.padding,
                textColor: (_isHovered && widget.invertHoverColor)
                    ? appBaseColor
                    : widget.textColor,
                disabledTextColor: widget.disabledTextColor,
                disabledBorderColor: Colors.black.withOpacity(0.3),
                hoverColor: widget.hoverColor,
                borderSide: BorderSide(color: widget.borderColor, width: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                onPressed: (widget.isDisabled) ? null : widget.onPressed,
                child: DankLabel(
                  displayText: widget.buttonText,
                  textAlign: TextAlign.center,
                  textStyle: widget.textStyle,
                  padding: widget.textPadding,
                ),
              )
            : FlatButton(
                padding: widget.padding,
                clipBehavior: Clip.none,
                color: widget.backgroundColor,
                textColor: widget.textColor,
                disabledTextColor: widget.disabledTextColor,
                disabledColor: Colors.black.withOpacity(0.3),
                hoverColor: Colors.black.withOpacity(0.3),
                shape: (widget.flatButtonShape ==
                        DankFlatButtonType.RoundedRectangle)
                    ? RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                      )
                    : StadiumBorder(),
                onPressed: (widget.isDisabled) ? null : widget.onPressed,
                child: Text(
                  widget.buttonText,
                  textAlign: TextAlign.center,
                  style: widget.textStyle,
                ),
              ),
      ),
    );
  }
}
