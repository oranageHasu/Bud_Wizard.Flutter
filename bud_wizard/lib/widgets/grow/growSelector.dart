import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/grow/growCard.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicIconButton.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class GrowSelector extends StatelessWidget {
  final List<Grow> grows;
  final Grow currentGrow;

  GrowSelector({
    @required List<Grow> grows,
    @required Grow currentGrow,
  })  : this.grows = grows,
        this.currentGrow = currentGrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      child: Column(
        children: [
          growOpPanel(context),
          for (Grow grow in grows)
            GrowCard(
              grow: grow,
              tooltipText: 'Click to see this Grow',
              isSelected: currentGrow == grow,
            ),
        ],
      ),
    );
  }

  Widget growOpPanel(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DankBasicIconButton(
              buttonType: DankButtonType.Outline,
              iconData: CommunityMaterialIcons.plus,
              iconSize: 25.0,
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appBaseWhiteTextColor
                  : appBaseBlackTextColor,
              showClickInteraction: true,
              tooltipText: 'Click to start a new grow',
              margin: EdgeInsets.only(left: 5.0),
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                GrowPage.of(context).startNewGrow();
              },
            ),
            Expanded(
              child: SizedBox.shrink(),
            ),
            DankBasicIconButton(
              buttonType: DankButtonType.Outline,
              iconData: CommunityMaterialIcons.pencil,
              iconSize: 25.0,
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appBaseWhiteTextColor
                  : appBaseBlackTextColor,
              showClickInteraction: true,
              tooltipText: 'Click to edit the current grow',
              padding: EdgeInsets.all(10.0),
              isDisabled: currentGrow == null,
              onPressed: () {
                print('To Do: Edit Grow');
              },
            ),
            DankBasicIconButton(
              buttonType: DankButtonType.Outline,
              iconData: CommunityMaterialIcons.delete,
              iconSize: 25.0,
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appBaseWhiteTextColor
                  : appBaseBlackTextColor,
              showClickInteraction: false,
              tooltipText: 'Click to delete the current grow',
              margin: EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.all(10.0),
              isDisabled: currentGrow == null,
              onPressed: () {
                GrowPage.of(context).deleteCurrentGrow();
              },
            ),
          ],
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Container(
          height: 5.0,
          margin: EdgeInsets.only(bottom: 5.0),
        ),
      ],
    );
  }
}
