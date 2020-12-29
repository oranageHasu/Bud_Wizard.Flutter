import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournal.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestions.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      color: appSecondColor,
      child: (currentOperation == PlantOperation.Journal)
          ? PlantJournal(currentPlant: currentPlant)
          : PlantQuestions(currentPlant: currentPlant),
    );
  }
}
