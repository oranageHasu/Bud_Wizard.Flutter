import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/menu/plantMenuItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantMenu extends StatefulWidget {
  final PlantOperation currentOperation;

  PlantMenu({
    @required PlantOperation currentOperation,
  }) : this.currentOperation = currentOperation;

  @override
  _PlantMenuState createState() => _PlantMenuState(
        this.currentOperation,
      );
}

class _PlantMenuState extends State<PlantMenu> {
  PlantOperation currentOperation;

  _PlantMenuState(
    this.currentOperation,
  );

  @override
  void didUpdateWidget(PlantMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    currentOperation = widget.currentOperation;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: appSecondColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PlantMenuItem(
              displayText: 'Journal',
              tooltipText: 'To Do',
              isSelected: currentOperation == PlantOperation.Journal,
              onSelected: selectPlantOperation,
              opType: PlantOperation.Journal,
            ),
            verticalDivider(),
            PlantMenuItem(
              displayText: 'Questions',
              tooltipText: 'To Do',
              isSelected: currentOperation == PlantOperation.Questions,
              onSelected: selectPlantOperation,
              opType: PlantOperation.Questions,
            ),
            verticalDivider(),
            PlantMenuItem(
              displayText: 'Statistics',
              tooltipText: 'To Do',
              isSelected: currentOperation == PlantOperation.Statistics,
              onSelected: selectPlantOperation,
              opType: PlantOperation.Statistics,
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalDivider() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: VerticalDivider(
        color: appThirdColor,
        width: 1.0,
        thickness: 2.0,
      ),
    );
  }

  void selectPlantOperation(PlantOperation newOperation) {
    setState(() {
      currentOperation = newOperation;
    });

    // Tell the parent its data has changed and force a re-render
    GrowPage.of(context).setCurrentPlantOperation(newOperation);
  }
}
