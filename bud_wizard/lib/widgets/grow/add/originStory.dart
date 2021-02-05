import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/grow%20system/growLight.dart';
import 'package:bud_wizard/widgets/grow/add/addGrow.dart';
import 'package:bud_wizard/widgets/grow/add/growLightSelector.dart';
import 'package:bud_wizard/widgets/grow/add/growSettingSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/slideIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-date-picker.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
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
      children: [
        DankLabel(
          displayText:
              'Start by providing some basic information about your grow...',
          textStyle: appInstructionHeaderFontStyle,
        ),
        SlideIn(
          1.5,
          FadeIn(
            duration: 1000,
            delay: Duration(milliseconds: 700),
            isVisible: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 400.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DankDatePicker(
                                  label: 'Start Date: ',
                                  defaultDate: DateTime.now(),
                                  onDateChanged: (DateTime date) {
                                    AddGrow.of(context).updateGrowDate(date);
                                  },
                                ),
                                GrowSettingSelector(
                                  grow: grow,
                                  selectionChanged: (GrowSetting setting) {
                                    AddGrow.of(context).setGrowSetting(setting);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            DankTextField(
                              labelText: 'Enter Grow Name',
                              hintText: 'Type the name of your grow',
                              margin: EdgeInsets.zero,
                              onChanged: (String value) {
                                AddGrow.of(context).updateGrowName(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: grow != null &&
                                grow.setting == GrowSetting.Indoor,
                            child: GrowLightSelector(
                              grow: grow,
                              selectionChanged: (List<GrowLight> lights) {
                                AddGrow.of(context).setGrowLighting(lights);
                              },
                            ),
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
}
