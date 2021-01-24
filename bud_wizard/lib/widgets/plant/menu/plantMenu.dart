import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/menu/plantIconMenu.dart';
import 'package:bud_wizard/widgets/plant/menu/plantMenuItem.dart';
import 'package:bud_wizard/widgets/user/userIconMenu.dart';
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
              tooltipText: 'This plant\'s history',
              isSelected: currentOperation == PlantOperation.Journal,
              onSelected: selectPlantOperation,
              opType: PlantOperation.Journal,
            ),
            verticalDivider(),
            PlantMenuItem(
              displayText: 'Questions',
              tooltipText: 'Have a question about this plant?',
              isSelected: currentOperation == PlantOperation.Questions,
              onSelected: selectPlantOperation,
              opType: PlantOperation.Questions,
              unreadNotificationCount: 3,
            ),
            verticalDivider(),
            PlantMenuItem(
              displayText: 'Statistics',
              tooltipText: 'How does this plant compare to others?',
              isSelected: currentOperation == PlantOperation.Statistics,
              onSelected: selectPlantOperation,
              opType: PlantOperation.Statistics,
              unreadNotificationCount: 1,
              displayNotificationAsAlert: true,
            ),
            Expanded(
              child: SizedBox.shrink(),
            ),
            PlantIconMenu(),
            UserIconMenu(),
          ],
        ),
      ),
    );
  }

  Widget verticalDivider() {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
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
