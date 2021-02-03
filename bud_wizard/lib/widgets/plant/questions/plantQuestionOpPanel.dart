import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantQuestionOpPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 25.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: SizedBox.shrink()),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: appBaseColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: DankLabel(
                      displayText: 'All',
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      textStyle: appLabelFontStyle.copyWith(
                        color: appBaseWhiteTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DankLabel(
                    displayText: 'Unanswered',
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    textStyle: appLabelFontStyle.copyWith(
                      color: appHintTextColor,
                    ),
                  ),
                  DankLabel(
                    displayText: 'Answered',
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    textStyle: appLabelFontStyle.copyWith(
                      color: appHintTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: appTertiaryColor,
            height: 2.0,
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
