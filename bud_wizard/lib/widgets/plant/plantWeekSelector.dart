import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/plantWeekCard.dart';
import 'package:flutter/material.dart';

class PlantWeekSelector extends StatelessWidget {
  final Plant currentPlant;

  PlantWeekSelector({
    Plant plant,
  }) : this.currentPlant = plant;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlantWeekCard(
          displayText: 'Germ',
          cardColor: growGerminationColor,
          weekNumber: 1,
          colorTransition: true,
        ),
        PlantWeekCard(
          displayText: 'Veg',
          cardColor: growVegetativeColor,
          weekNumber: 2,
        ),
        PlantWeekCard(
          displayText: 'Veg',
          cardColor: growVegetativeColor,
          weekNumber: 3,
        ),
        PlantWeekCard(
          displayText: 'Veg',
          cardColor: growVegetativeColor,
          weekNumber: 4,
          colorTransition: true,
        ),
        PlantWeekCard(
          displayText: 'Flow',
          cardColor: growFloweringColor,
          weekNumber: 5,
        ),
        PlantWeekCard(
          displayText: 'Flow',
          cardColor: growFloweringColor,
          weekNumber: 6,
        ),
        PlantWeekCard(
          displayText: 'Flow',
          cardColor: growFloweringColor,
          weekNumber: 7,
        ),
        PlantWeekCard(
          displayText: 'Flow',
          cardColor: growFloweringColor,
          weekNumber: 8,
          colorTransition: true,
        ),
        PlantWeekCard(
          displayText: 'Dry',
          cardColor: growDryingColor,
          weekNumber: 9,
          colorTransition: true,
        ),
        PlantWeekCard(
          displayText: 'Cure',
          cardColor: growCuringColor,
          weekNumber: 10,
        ),
        PlantWeekCard(
          displayText: 'Cure',
          cardColor: growCuringColor,
          weekNumber: 11,
        ),
        PlantWeekCard(
          displayText: 'Cure',
          cardColor: growCuringColor,
          weekNumber: 12,
        ),
      ],
    );
  }
}
