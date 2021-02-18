import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant%20system/plant.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournal.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestions.dart';
import 'package:bud_wizard/widgets/plant/statistics/plantStatistics.dart';
import 'package:flutter/material.dart';

class PlantDetail extends StatelessWidget {
  final Plant currentPlant;
  final PlantOperation currentOperation;

  PlantDetail({
    Plant plant,
    PlantOperation operation,
  })  : this.currentPlant = plant,
        this.currentOperation = operation;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 500.0),
      color: (currentTheme.currentTheme() == ThemeMode.dark)
          ? appDarkSecondaryColor
          : appLightSecondaryColor,
      child: getCurrentScreen(),
    );
  }

  Widget getCurrentScreen() {
    Widget retval;

    switch (currentOperation) {
      case PlantOperation.Journal:
        retval = PlantJournal(currentPlant: currentPlant);
        break;

      case PlantOperation.Questions:
        retval = PlantQuestions(currentPlant: currentPlant);
        break;

      case PlantOperation.Statistics:
        retval = PlantStatistics(currentPlant: currentPlant);
        break;
    }

    return retval;
  }
}
