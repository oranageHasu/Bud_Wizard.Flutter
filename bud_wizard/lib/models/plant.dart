import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';

class Plant {

  final Guid plantId;
  final Guid growId;
  final String name;
  final DateTime startDate;
  final String strain;
  final GeneticType genetics;
  final Gender sex;
  final GrowState growthState;

  Plant({
    this.plantId,
    this.growId,
    this.name,
    this.startDate,
    this.strain,
    this.genetics,
    this.sex,
    this.growthState
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      plantId: new Guid(json['plantId']),
      growId: new Guid(json['growId']),
      name: json['name'],
      strain: json['strain'],
      /*
      startDate: new DateTime(json['startDate']),
      genetics: GeneticType.unknownHybrid,
      sex: Gender.unknown,
      growthState: GrowState.flowering,
      */
    );
  }
}