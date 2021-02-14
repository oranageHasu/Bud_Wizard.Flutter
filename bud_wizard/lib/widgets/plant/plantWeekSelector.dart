import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/widgets/plant/plantWeekCard.dart';
import 'package:flutter/material.dart';

class PlantWeekSelector extends StatelessWidget {
  final Journal journal;
  final int currentIndex;

  PlantWeekSelector({
    @required Journal journal,
    @required int currentIndex,
  })  : this.journal = journal,
        this.currentIndex = currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (JournalWeek week in journal.plantWeeks)
          PlantWeekCard(
            displayText: week.getAbbrWeekText(),
            cardColor: getGrowthStateColor(week.growthState),
            weekNumber: week.weekNumber,
            colorTransition: week.hasGrowthStateTransition(),
            isSelected: currentIndex == week.weekNumber,
          ),
      ],
    );
  }
}
