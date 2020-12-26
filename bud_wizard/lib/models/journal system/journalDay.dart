import 'package:bud_wizard/models/journal%20system/journalEntry.dart';
import 'package:flutter_guid/flutter_guid.dart';

class JournalDay {
  final Guid journalDayId;
  final Guid journalWeekId;
  final DateTime entryDate;
  List<JournalEntry> journalEntries;

  JournalDay({
    this.journalDayId,
    this.journalWeekId,
    this.entryDate,
    this.journalEntries,
  });

  factory JournalDay.fromJson(Map<String, dynamic> json) {
    return JournalDay(
      journalDayId: new Guid(json['journalDayId']),
      journalWeekId: new Guid(json['journalWeekId']),
      entryDate: DateTime.parse(json['entryDate']),
      journalEntries: (json['journalEntries'] as List)
          .map((journalEntries) => new JournalEntry.fromJson(journalEntries))
          .toList(),
    );
  }
}
