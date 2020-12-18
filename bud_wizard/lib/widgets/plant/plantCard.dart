import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final bool isFeatured;
  final bool isLeftSide;

  PlantCard({
    Plant plant,
    bool isFeatured = false,
    bool isLeftSide = false,
  })  : this.plant = plant,
        this.isFeatured = isFeatured,
        this.isLeftSide = isLeftSide;

  @override
  Widget build(BuildContext context) {
    double cardPadding = 10.0;

    return Card(
      color: appBaseBackgroundColor,
      elevation: 15.0,
      clipBehavior: Clip.hardEdge,
      margin: (isFeatured)
          ? EdgeInsets.all(cardPadding)
          : EdgeInsets.only(
              left: (!isLeftSide) ? cardPadding / 2 : cardPadding,
              right: (isLeftSide) ? cardPadding / 2 : cardPadding,
              bottom: cardPadding,
            ),
      child: Stack(
        children: [
          Container(
            height: (isFeatured) ? 400.0 : 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: (isFeatured) ? 300.0 : 250.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Image.asset(
                    plant.imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DankLabel(
                        displayText: plant.strain,
                        textStyle: appHeaderFontStyle.copyWith(
                          fontSize: 18.0,
                        ),
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                    ),
                    DankLabel(
                      displayText: formatEnum(plant.growthState.toString()),
                      textStyle: appInputLabelFontStyle.copyWith(
                        color: plant.getGrowthStateColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      plant.getGenderIcon(),
                      fit: BoxFit.scaleDown,
                      height: 50.0,
                      width: 50.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                hoverColor: Colors.black.withOpacity(0.2),
                splashColor: Colors.black.withOpacity(0.2),
                onTap: () => {print('To Do: Plant Clicked.')},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
