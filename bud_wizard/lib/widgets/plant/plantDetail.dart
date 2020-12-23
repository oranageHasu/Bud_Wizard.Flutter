import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageDialog.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageSelector.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/plant/plantWeekSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantDetail extends StatefulWidget {
  final Plant currentPlant;

  PlantDetail({
    Plant plant,
  }) : this.currentPlant = plant;

  @override
  _PlantDetailState createState() => _PlantDetailState(this.currentPlant);
}

class _PlantDetailState extends State<PlantDetail> {
  Plant currentPlant;

  _PlantDetailState(
    this.currentPlant,
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appSecondColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          DankLabel(
            displayText: currentPlant.name,
            textAlign: TextAlign.left,
            textStyle: appHeaderFontStyle.copyWith(
              fontSize: 22.0,
              color: appBaseColor.withOpacity(0.9),
            ),
            padding: EdgeInsets.only(
              left: 15.0,
              top: 10.0,
            ),
          ),
          PlantCard(
            plant: currentPlant,
            isFeatured: true,
            isSelectable: false,
          ),
          PlantWeekSelector(plant: currentPlant),
          PlantImageSelector(plant: currentPlant),
          Expanded(
            child: Container(
              color: appSecondColor,
            ),
          ),
        ],
      ),
    );
  }
}
