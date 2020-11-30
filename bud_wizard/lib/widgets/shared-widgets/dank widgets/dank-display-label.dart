import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';

class DankDisplayLabel extends StatelessWidget {
  final String label;
  final String value;

  DankDisplayLabel({String label, String value})
      : this.label = label,
        this.value = value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: appDescriptorLabelFontStyle,
        ),
        Text(
          value,
          style: appLabelFontStyle,
        ),
      ],
    );
  }
}
