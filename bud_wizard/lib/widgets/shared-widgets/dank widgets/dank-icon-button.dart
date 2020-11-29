import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';

class DankIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback callback;

  DankIconButton({IconData iconData, VoidCallback callback})
      : this.iconData = iconData,
        this.callback = callback;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: appBaseColor, width: 2.0),
      shape: StadiumBorder(),
      hoverColor: Colors.transparent,
      onPressed: callback,
      child: new Icon(iconData, color: appBaseColor),
    );
  }
}
