import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/widgets/grow/add/addGrow.dart';
import 'package:bud_wizard/widgets/grow/add/growSettingSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/slideIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-chip.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-date-picker.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-pro-tip.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';

class OriginStory extends StatelessWidget {
  final Grow grow;

  OriginStory({
    @required Grow grow,
  }) : this.grow = grow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DankLabel(
          displayText:
              'Start by providing some basic information about your grow...',
          textStyle: appInstructionHeaderFontStyle,
        ),
        SlideIn(
          2,
          FadeIn(
            duration: 1000,
            delay: Duration(milliseconds: 700),
            isVisible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DankTextField(
                            labelText: 'Enter Grow Name',
                            hintText: 'Type the name of your grow',
                            maxWidth: 600.0,
                            margin: EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            onChanged: (String value) {
                              AddGrow.of(context).updateGrowName(value);
                            },
                          ),
                          DankProTip(
                            proTipText:
                                'A well named grow can help expose your plants to other users.',
                            onLearnMore: learnMoreAboutGrows,
                          ),
                          DankDatePicker(
                            defaultDate: DateTime.now(),
                            onDateChanged: (DateTime date) {
                              AddGrow.of(context).updateGrowDate(date);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GrowSettingSelector(
                            grow: grow,
                            selectionChanged: (GrowSetting setting) {
                              AddGrow.of(context).setGrowSetting(setting);
                            },
                          ),
                          Visibility(
                            visible: grow != null &&
                                grow.setting == GrowSetting.Indoor,
                            child: buildLightSelector(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLightSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DankLabel(
          displayText: 'Lighting:',
          textStyle: appLabelFontStyle,
          textAlign: TextAlign.start,
          padding: EdgeInsets.only(
            bottom: 10.0,
            top: 20.0,
          ),
        ),
        Row(
          children: [
            DankChip(
              onTapped: removeLight,
              label: DankLabel(
                displayText: 'spider farmer sf1000',
                textStyle: appLabelFontStyle.copyWith(
                  fontSize: 14.0,
                  color: appBaseColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DankChip(
              onTapped: removeLight,
              label: DankLabel(
                displayText: 'spider farmer sf2000',
                textStyle: appLabelFontStyle.copyWith(
                  fontSize: 14.0,
                  color: appBaseColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void removeLight() {
    print('To Do: Remove Light');
  }

  void learnMoreAboutGrows() {
    print('To Do: Knowledge Base: Grows');
  }
}
