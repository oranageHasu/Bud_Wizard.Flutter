import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:flutter_guid/flutter_guid.dart';

class Journal {
  final Guid journalId;
  final Guid userId;
  final Guid plantId;
  bool isDeleted;
  List<JournalWeek> plantWeeks;

  Journal({
    this.journalId,
    this.userId,
    this.plantId,
    this.isDeleted,
    this.plantWeeks,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      journalId: Guid(json['journalId']),
      userId: Guid(json['userId']),
      plantId: Guid(json['plantId']),
      isDeleted: json['isDeleted'],
      plantWeeks: (json['plantWeeks'] as List)
          .map((plantWeeks) => JournalWeek.fromJson(plantWeeks))
          .toList(),
    );
  }
}
