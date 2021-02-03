import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/grow%20system/growPrivacy.dart';
import 'package:bud_wizard/widgets/grow/add/addGrow.dart';
import 'package:bud_wizard/widgets/grow/add/privacySelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/slideIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-pro-tip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Privacy extends StatelessWidget {
  final Grow grow;

  Privacy({
    @required Grow grow,
  }) : this.grow = grow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DankLabel(
          displayText:
              'Tell us what type of exposure you\'d like to receive...',
          textStyle: appInstructionHeaderFontStyle,
        ),
        Expanded(
          child: SlideIn(
            1.5,
            FadeIn(
              duration: 1000,
              delay: Duration(milliseconds: 700),
              isVisible: true,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 30.0,
                      bottom: 8.0,
                    ),
                    child: PrivacySelector(
                      grow: grow,
                      selectionChanged: privacyChanged,
                    ),
                  ),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void privacyChanged(GrowPrivacy privacySettings) {
    AddGrow.of(Get.context).updatePrivacy(privacySettings);
  }
}
