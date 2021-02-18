import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant%20system/plant.dart';
import 'package:bud_wizard/widgets/grow/growCard.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicIconButton.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GrowSelector extends StatefulWidget {
  final List<Grow> grows;
  final Grow currentGrow;
  final Plant currentPlant;
  final VoidCallback hoverBegins;
  final VoidCallback hoverEnds;

  GrowSelector({
    @required List<Grow> grows,
    @required Grow currentGrow,
    @required Plant currentPlant,
    VoidCallback hoverBegins,
    VoidCallback hoverEnds,
  })  : this.grows = grows,
        this.currentGrow = currentGrow,
        this.currentPlant = currentPlant,
        this.hoverBegins = hoverBegins,
        this.hoverEnds = hoverEnds;

  @override
  _GrowSelectorState createState() => _GrowSelectorState();
}

class _GrowSelectorState extends State<GrowSelector> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        if (!_isHovered) {
          _isHovered = true;

          if (widget.hoverBegins != null) {
            widget.hoverBegins();
          }
        }
      },
      onExit: (PointerExitEvent event) {
        if (_isHovered) {
          _isHovered = false;

          if (widget.hoverEnds != null) {
            widget.hoverEnds();
          }
        }
      },
      child: Container(
        width: 275.0,
        color: (currentTheme.isDarkTheme())
            ? appDarkTertiaryColor
            : appLightTertiaryColor,
        child: Stack(
          children: [
            Column(
              children: [
                for (Grow grow in widget.grows)
                  GrowCard(
                    grow: grow,
                    tooltipText: 'Click to see this Grow',
                    isSelected: widget.currentGrow == grow,
                    currentPlant: widget.currentPlant,
                  ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
                growOpPanel(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget growOpPanel(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5.0,
          margin: EdgeInsets.only(bottom: 5.0),
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
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
            DankBasicIconButton(
              buttonType: DankButtonType.Outline,
              iconData: CommunityMaterialIcons.cannabis,
              iconSize: 25.0,
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appBaseWhiteTextColor
                  : appBaseBlackTextColor,
              showClickInteraction: true,
              tooltipText: 'Click to add a new plant to the current grow',
              padding: EdgeInsets.all(10.0),
              isDisabled: widget.currentGrow == null,
              onPressed: () {
                GrowPage.of(context).startNewPlant();
              },
            ),
            Expanded(
              child: SizedBox.shrink(),
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
              isDisabled: widget.currentGrow == null,
              onPressed: () {
                GrowPage.of(context).deleteCurrentGrow();
              },
            ),
          ],
        ),
      ],
    );
  }
}
