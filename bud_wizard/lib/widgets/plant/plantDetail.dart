import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageSelector.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournal.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/plant/plantWeekSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantDetail extends StatefulWidget {
  final Plant currentPlant;
  final PlantOperation currentOperation;

  PlantDetail({
    Plant plant,
    PlantOperation operation,
  })  : this.currentPlant = plant,
        this.currentOperation = operation;

  @override
  _PlantDetailState createState() => _PlantDetailState(
        this.currentPlant,
        this.currentOperation,
      );
}

class _PlantDetailState extends State<PlantDetail> {
  Plant currentPlant;
  PlantOperation currentOperation;

  _PlantDetailState(
    this.currentPlant,
    this.currentOperation,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantDetail oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPlant != widget.currentPlant) {
      currentPlant = widget.currentPlant;
    }

    currentOperation = widget.currentOperation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appSecondColor,
      child: (currentOperation == PlantOperation.Journal)
          ? plantJournal()
          : other(),
    );
  }

  Widget plantJournal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        PlantCard(
          plant: currentPlant,
          isFeatured: true,
          isSelectable: false,
        ),
        PlantWeekSelector(plant: currentPlant),
        DankLabel(
          displayText: 'Weekly Journal',
          textStyle: appHeaderFontStyle.copyWith(fontSize: 20.0),
          textAlign: TextAlign.center,
          padding: EdgeInsets.only(top: 10.0),
        ),
        DankLabel(
          displayText: 'Dec 13th, 2020 - Dec 19th, 2020',
          textStyle: appInputHintFontStyle,
          textAlign: TextAlign.center,
          padding: EdgeInsets.only(top: 5.0),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Divider(
            color: appThirdColor,
            height: 2.0,
            thickness: 2.0,
            indent: 25.0,
            endIndent: 25.0,
          ),
        ),
        PlantImageSelector(plant: currentPlant),
        Expanded(
          child: PlantJournal(plant: currentPlant),
        ),
      ],
    );
  }

  Widget other() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox.shrink(),
        ),
      ],
    );
  }
}
