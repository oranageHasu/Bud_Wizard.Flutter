import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';

class Grow {
  final Guid growId;
  final Guid userId;
  String name;
  DateTime startDate;
  GrowSetting setting;
  LightStyle light;
  bool isDeleted;
  List<Plant> plants;

  Grow(
      {this.growId,
      this.userId,
      this.name,
      this.startDate,
      this.setting,
      this.light,
      this.isDeleted,
      this.plants});

  factory Grow.fromJson(Map<String, dynamic> json) {
    return Grow(
      growId: new Guid(json['growId']),
      userId: new Guid(json['userId']),
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      setting: GrowSetting.values
          .firstWhere((e) => e.index == json['setting'] as int),
      light:
          LightStyle.values.firstWhere((e) => e.index == json['light'] as int),
      isDeleted: json['isDeleted'],
      plants: (json['plants'] as List)
          .map((plants) => new Plant.fromJson(plants))
          .toList(),
    );
  }
}
