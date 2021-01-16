import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/widgets/grow/growSearch.dart';
import 'package:bud_wizard/widgets/plant/menu/plantMenu.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/user/userIconMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GrowPageHeader extends StatelessWidget {
  final bool isPlantSelected;
  final Grow currentGrow;
  final PlantOperation currentPlantOp;

  GrowPageHeader({
    @required Grow currentGrow,
    @required PlantOperation currentPlantOp,
    bool isPlantSelected = false,
  })  : this.currentGrow = currentGrow,
        this.currentPlantOp = currentPlantOp,
        this.isPlantSelected = isPlantSelected;

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
            (isPlantSelected)
                ? PlantMenu(currentOperation: currentPlantOp)
                : Expanded(
                    child: Container(
                      color: appSecondColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: DankLabel(
                              displayText:
                                  (currentGrow != null) ? currentGrow.name : '',
                              textStyle: appLabelFontStyle,
                              textAlign: TextAlign.center,
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 2.0),
                            ),
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                          ),
                          UserIconMenu(),
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
