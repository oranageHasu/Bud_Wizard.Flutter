import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class TechIntegrations extends StatelessWidget {
  final Grow grow;

  TechIntegrations({
    @required Grow grow,
  }) : this.grow = grow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DankLabel(
          displayText: 'To Do: Tech Integrations',
          textStyle: appInstructionHeaderFontStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
