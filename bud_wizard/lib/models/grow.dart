import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';

class Grow {

  final Guid growId;
  final Guid userId;
  final String name;
  final DateTime startDate;
  final GrowSetting setting;
  final LightStyle light;
  final bool isDeleted;
  final List<Plant> plants;

  Grow({
    this.growId,
    this.userId,
    this.name,
    this.startDate,
    this.setting,
    this.light,
    this.isDeleted,
    this.plants
  });

  factory Grow.fromJson(Map<String, dynamic> json) {
    return Grow(
      growId: new Guid(json['growId']),
      userId: new Guid(json['userId']),
      name: json['name'],
    );
  }
}