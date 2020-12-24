import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantJournalEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Card(
        color: appThirdColor,
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DankLabel(
                displayText: 'Dec 15, 2020',
                textStyle: appLabelFontStyle,
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              DankLabel(
                displayText: '-Measured height; 42.5"',
                textStyle: appLabelFontStyle.copyWith(fontSize: 15.0),
                padding: EdgeInsets.only(left: 30.0),
              ),
              DankLabel(
                displayText:
                    '-Attempted yield projection.  Suggested to re-attempt Dec 21, 2020',
                textStyle: appLabelFontStyle.copyWith(fontSize: 15.0),
                padding: EdgeInsets.only(left: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
