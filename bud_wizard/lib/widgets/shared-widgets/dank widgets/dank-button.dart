import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';

class DankButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback callback;

  DankButton({String buttonText, VoidCallback callback})
      : this.buttonText = buttonText,
        this.callback = callback;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      padding: EdgeInsets.all(15.0),
      borderSide: BorderSide(color: appBaseColor, width: 2.0),
      shape: StadiumBorder(),
      hoverColor: Colors.transparent,
      onPressed: callback,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: appInputFontStyle.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: appBaseWhiteTextColor.shade700,
        ),
      ),
    );
  }
}
