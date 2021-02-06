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
              buttonType: DankButtonType.Icon,
              iconData: CommunityMaterialIcons.plus_circle,
              iconSize: 35.0,
              showClickInteraction: true,
              tooltipText: 'Click to start a new grow',
              margin: EdgeInsets.only(left: 5.0, bottom: 5.0),
              onPressed: () {
                GrowPage.of(context).startNewGrow();
              },
            ),
            Expanded(
              child: SizedBox.shrink(),
            ),
            DankBasicIconButton(
              buttonType: DankButtonType.Icon,
              iconData: CommunityMaterialIcons.pencil_circle,
              iconSize: 35.0,
              color: appBaseWhiteTextColor,
              showClickInteraction: true,
              tooltipText: 'Click to edit the current grow',
              margin: EdgeInsets.only(bottom: 5.0),
              isDisabled: currentGrow == null,
              onPressed: () {
                print('To Do: Edit Grow');
              },
            ),
            DankBasicIconButton(
              buttonType: DankButtonType.Icon,
              iconData: CommunityMaterialIcons.delete_circle,
              iconSize: 35.0,
              color: Colors.red.shade200,
              showClickInteraction: false,
              tooltipText: 'Click to delete the current grow',
              margin: EdgeInsets.only(
                bottom: 5.0,
                right: 5.0,
              ),
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
          color: appBackgroundColor,
        ),
        Container(
          height: 5.0,
          margin: EdgeInsets.only(bottom: 5.0),
        ),
      ],
    );
  }
}
