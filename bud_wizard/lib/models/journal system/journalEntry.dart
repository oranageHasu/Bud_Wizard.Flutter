import 'package:flutter_guid/flutter_guid.dart';

class JournalEntry {
  final Guid journalEntryId;
  final Guid journalDayId;
  final DateTime entryDate;
  String entry;

  JournalEntry({
    this.journalEntryId,
    this.journalDayId,
    this.entryDate,
    this.entry,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      journalEntryId: new Guid(json['journalEntryId']),
      journalDayId: new Guid(json['journalDayId']),
      entryDate: DateTime.parse(json['entryDate']),
      entry: json['entry'],
    );
  }
}
