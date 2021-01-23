import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:flutter/material.dart';

class DankButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool isDisabled;
  final DankButtonType buttonType;
  final Color textColor;
  final Color disabledTextColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final DankFlatButtonType flatButtonShape;
  final TextStyle textStyle;

  DankButton({
    @required buttonText,
    @required onPressed,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(0.0),
    bool isDisabled = false,
    DankButtonType buttonType = DankButtonType.Outline,
    Color textColor = appBaseWhiteTextColor,
    Color disabledTextColor = appBaseWhiteTextColor,
    Color backgroundColor = appPrimaryColor,
    Color borderColor = appPrimaryColor,
    double borderRadius = 0.0,
    DankFlatButtonType flatButtonShape = DankFlatButtonType.RoundedRectangle,
    TextStyle textStyle = appButtonFontStyle,
  })  : this.buttonText = buttonText,
        this.onPressed = onPressed,
        this.margin = margin,
        this.padding = padding,
        this.isDisabled = isDisabled,
        this.buttonType = buttonType,
        this.textColor = textColor,
        this.disabledTextColor = disabledTextColor,
        this.backgroundColor = backgroundColor,
        this.borderColor = borderColor,
        this.borderRadius = borderRadius,
        this.flatButtonShape = flatButtonShape,
        this.textStyle = textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: (buttonType == DankButtonType.Outline)
          ? OutlineButton(
              padding: padding,
              textColor: textColor,
              disabledTextColor: disabledTextColor,
              disabledBorderColor: Colors.black.withOpacity(0.3),
              color: appBaseColor,
              hoverColor: Colors.white.withOpacity(0.1),
              borderSide: BorderSide(color: borderColor, width: 2.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              onPressed: (isDisabled) ? null : onPressed,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            )
          : FlatButton(
              padding: padding,
              clipBehavior: Clip.none,
              color: backgroundColor,
              textColor: textColor,
              disabledTextColor: disabledTextColor,
              disabledColor: Colors.black.withOpacity(0.3),
              hoverColor: Colors.black.withOpacity(0.3),
              shape: (flatButtonShape == DankFlatButtonType.RoundedRectangle)
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    )
                  : StadiumBorder(),
              onPressed: (isDisabled) ? null : onPressed,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
    );
  }
}
