import 'package:flutter/foundation.dart';
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

  Grow({
    @required Guid userId,
    Guid growId,
    String name,
    DateTime startDate,
    GrowSetting setting = GrowSetting.Indoor,
    LightStyle light = LightStyle.LED,
    bool isDeleted = false,
    List<Plant> plants,
  })  : this.userId = userId,
        this.growId = growId,
        this.name = name,
        this.startDate = startDate,
        this.setting = setting,
        this.light = light,
        this.isDeleted = isDeleted,
        this.plants = plants;

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
