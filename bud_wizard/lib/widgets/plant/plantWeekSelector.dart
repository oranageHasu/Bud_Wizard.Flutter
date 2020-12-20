import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/plantWeekCard.dart';
import 'package:flutter/material.dart';

class PlantWeekSelector extends StatefulWidget {
  final Plant currentPlant;
  final int currentIndex;

  PlantWeekSelector({
    Plant plant,
    int currentIndex = 1,
  })  : this.currentPlant = plant,
        this.currentIndex = currentIndex;

  @override
  _PlantWeekSelectorState createState() => _PlantWeekSelectorState(
        this.currentPlant,
        this.currentIndex,
      );
}

class _PlantWeekSelectorState extends State<PlantWeekSelector> {
  Plant currentPlant;
  int currentIndex;

  _PlantWeekSelectorState(
    this.currentPlant,
    this.currentIndex,
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
  void didUpdateWidget(PlantWeekSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.currentIndex = widget.currentIndex;
    this.currentPlant = widget.currentPlant;
  }

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
          isSelected: currentIndex == 1,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Veg',
          cardColor: growVegetativeColor,
          weekNumber: 2,
          isSelected: currentIndex == 2,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Veg',
          cardColor: growVegetativeColor,
          weekNumber: 3,
          isSelected: currentIndex == 3,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Veg',
          cardColor: growVegetativeColor,
          weekNumber: 4,
          colorTransition: true,
          isSelected: currentIndex == 4,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Flower',
          cardColor: growFloweringColor,
          weekNumber: 5,
          isSelected: currentIndex == 5,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Flower',
          cardColor: growFloweringColor,
          weekNumber: 6,
          isSelected: currentIndex == 6,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Flower',
          cardColor: growFloweringColor,
          weekNumber: 7,
          isSelected: currentIndex == 7,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Flower',
          cardColor: growFloweringColor,
          weekNumber: 8,
          colorTransition: true,
          isSelected: currentIndex == 8,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Dry',
          cardColor: growDryingColor,
          weekNumber: 9,
          colorTransition: true,
          isSelected: currentIndex == 9,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Cure',
          cardColor: growCuringColor,
          weekNumber: 10,
          isSelected: currentIndex == 10,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Cure',
          cardColor: growCuringColor,
          weekNumber: 11,
          isSelected: currentIndex == 11,
          onClicked: weekSelected,
        ),
        PlantWeekCard(
          displayText: 'Cure',
          cardColor: growCuringColor,
          weekNumber: 12,
          isSelected: currentIndex == 12,
          onClicked: weekSelected,
        ),
      ],
    );
  }

  void weekSelected(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }
}
