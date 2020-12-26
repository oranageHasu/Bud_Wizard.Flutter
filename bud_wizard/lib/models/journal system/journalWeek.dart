import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:flutter_guid/flutter_guid.dart';

class JournalWeek {
  final Guid journalWeekId;
  final Guid journalId;
  final int weekNumber;
  List<JournalDay> plantDays;

  JournalWeek({
    this.journalWeekId,
    this.journalId,
    this.weekNumber,
    this.plantDays,
  });

  factory JournalWeek.fromJson(Map<String, dynamic> json) {
    return JournalWeek(
      journalWeekId: new Guid(json['journalWeekId']),
      journalId: new Guid(json['journalId']),
      weekNumber: json['weekNumber'],
      plantDays: (json['plantDays'] as List)
          .map((plantWeeks) => new JournalDay.fromJson(plantWeeks))
          .toList(),
    );
  }
}
