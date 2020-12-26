import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:flutter_guid/flutter_guid.dart';

class Journal {
  final Guid journalId;
  final Guid plantId;
  bool isDeleted;
  List<JournalWeek> plantWeeks;

  Journal({
    this.journalId,
    this.plantId,
    this.isDeleted,
    this.plantWeeks,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      journalId: new Guid(json['journalId']),
      plantId: new Guid(json['plantId']),
      isDeleted: json['isDeleted'],
      plantWeeks: (json['plantWeeks'] as List)
          .map((plantWeeks) => new JournalWeek.fromJson(plantWeeks))
          .toList(),
    );
  }
}
