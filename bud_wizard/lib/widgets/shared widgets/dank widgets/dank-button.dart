import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:flutter/material.dart';

class DankButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback callback;
  final EdgeInsets margin;
  final bool isDisabled;
  final DankButtonType buttonType;

  DankButton({
    @required buttonText,
    @required callback,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    bool isDisabled = false,
    DankButtonType buttonType = DankButtonType.Outline,
  })  : this.buttonText = buttonText,
        this.callback = callback,
        this.margin = margin,
        this.isDisabled = isDisabled,
        this.buttonType = buttonType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
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
              onPressed: (isDisabled) ? null : callback,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: appButtonFontStyle,
              ),
            )
          : FlatButton(
              padding: EdgeInsets.all(18.0),
              clipBehavior: Clip.none,
              color: appBaseColor,
              textColor: Colors.black,
              disabledTextColor: appBaseWhiteTextColor,
              disabledColor: Colors.black.withOpacity(0.3),
              hoverColor: Colors.black.withOpacity(0.3),
              shape: StadiumBorder(),
              onPressed: (isDisabled) ? null : callback,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: appButtonFontStyle,
              ),
            ),
    );
  }
}
