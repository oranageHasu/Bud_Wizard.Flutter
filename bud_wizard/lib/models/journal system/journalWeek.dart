import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:bud_wizard/models/journal%20system/journalEntry.dart';
import 'package:flutter_guid/flutter_guid.dart';

class JournalWeek {
  final Guid journalWeekId;
  final Guid journalId;
  final int weekNumber;
  final GrowState growthState;
  final DateTime startDate;
  List<JournalDay> plantDays;

  JournalWeek({
    GrowState growState,
    this.journalWeekId,
    this.journalId,
    this.weekNumber,
    this.startDate,
    this.plantDays,
  }) : this.growthState = growState;

  factory JournalWeek.fromJson(Map<String, dynamic> json) {
    return JournalWeek(
      journalWeekId: Guid(json['journalWeekId']),
      journalId: Guid(json['journalId']),
      weekNumber: json['weekNumber'],
      growState: GrowState.values
          .firstWhere((e) => e.index == json['growthState'] as int),
      startDate: DateTime.parse(json['startDate']),
      plantDays: (json['plantDays'] as List)
          .map((plantWeeks) => JournalDay.fromJson(plantWeeks))
          .toList(),
    );
  }

  String getAbbrWeekText() {
    String retval;

    switch (growthState) {
      case GrowState.Germination:
        retval = 'Germ';
        break;

      case GrowState.Vegetative:
        retval = 'Veg';
        break;

      case GrowState.Flowering:
        retval = 'Flower';
        break;

      case GrowState.Drying:
        retval = 'Dry';
        break;

      case GrowState.Curing:
        retval = 'Cure';
        break;
    }

    print(GrowState.values
        .firstWhere((e) => e.index == GrowState.Germination.index)
        .index);
    print('grow state: ' + growthState.toString());
    print('abbr grow state: ' + retval);

    return retval;
  }

  bool hasGrowthStateTransition() {
    bool retval = false;

    if (growthState != GrowState.Curing && plantDays != null) {
      for (JournalDay day in plantDays) {
        if (day.journalEntries != null) {
          JournalEntry test = day.journalEntries.singleWhere(
              (entry) => entry.growStateTransitionOccurred,
              orElse: () => null);

          if (test != null) {
            retval = true;
            break;
          }
        }
      }
    }

    return retval;
  }
}
