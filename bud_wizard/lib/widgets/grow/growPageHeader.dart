import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/grow/growSearch.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class GrowPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.0),
      decoration: BoxDecoration(
        color: appThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GrowSearch(),
            Expanded(
              child: Container(
                color: appSecondColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: DankLabel(
                        displayText: 'Plants',
                        textStyle: appLabelFontStyle,
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      child: VerticalDivider(
                        color: appThirdColor,
                        width: 1.0,
                        thickness: 2.0,
                      ),
                    ),
                    Center(
                      child: DankLabel(
                        displayText: 'Questions',
                        textStyle:
                            appLabelFontStyle.copyWith(color: appHintTextColor),
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      child: VerticalDivider(
                        color: appThirdColor,
                        width: 1.0,
                        thickness: 2.0,
                      ),
                    ),
                    Center(
                      child: DankLabel(
                        displayText: 'Statistics',
                        textStyle:
                            appLabelFontStyle.copyWith(color: appHintTextColor),
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
