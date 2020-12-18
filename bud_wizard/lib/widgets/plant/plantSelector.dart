import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantSelector extends StatelessWidget {
  final Grow grow;

  PlantSelector({
    Grow grow,
  }) : this.grow = grow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DankLabel(
          displayText: 'Featured Grow',
          textAlign: TextAlign.left,
          textStyle: appHeaderFontStyle.copyWith(
            fontSize: 26.0,
          ),
          padding: EdgeInsets.only(
            left: 15.0,
            top: 10.0,
          ),
        ),
        PlantCard(
          plant: grow.plants[0],
          isFeatured: true,
        ),
        Row(
          children: [
            if (grow.plants.length > 1)
              Expanded(
                child: PlantCard(
                  plant: grow.plants[1],
                  isLeftSide: true,
                ),
              ),
            (grow.plants.length > 2)
                ? Expanded(
                    child: PlantCard(
                      plant: grow.plants[2],
                    ),
                  )
                : Expanded(child: SizedBox(height: 300.0)),
          ],
        ),
      ],
    );
  }
}
