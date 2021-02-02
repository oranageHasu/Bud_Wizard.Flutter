import 'package:bud_wizard/models/grow%20system/growLight.dart';
import 'package:bud_wizard/models/grow%20system/growPrivacy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';

class Grow {
  final Guid growId;
  final Guid userId;
  String name;
  DateTime startDate = DateTime.now();
  GrowSetting setting;
  bool isDeleted;
  List<GrowLight> growLights;
  List<Plant> plants = List<Plant>();
  GrowPrivacy privacySettings =
      GrowPrivacy(privacySetting: GrowPrivacySetting.DoNotShare);

  Grow({
    @required Guid userId,
    Guid growId,
    String name,
    DateTime startDate,
    GrowSetting setting = GrowSetting.Indoor,
    List<GrowLight> growLights,
    bool isDeleted = false,
    List<Plant> plants,
    GrowPrivacy privacySettings,
  })  : this.userId = userId,
        this.growId = growId,
        this.name = name,
        this.startDate = startDate,
        this.setting = setting,
        this.growLights = growLights,
        this.isDeleted = isDeleted,
        this.plants = plants,
        this.privacySettings = privacySettings;

  factory Grow.fromJson(Map<String, dynamic> json) {
    return Grow(
      growId: new Guid(json['growId']),
      userId: new Guid(json['userId']),
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      setting: GrowSetting.values
          .firstWhere((e) => e.index == json['setting'] as int),
      growLights: (json['growLights'] as List)
          .map((growLight) => new GrowLight.fromJson(growLight))
          .toList(),
      isDeleted: json['isDeleted'],
      plants: (json['plants'] as List)
          .map((plant) => new Plant.fromJson(plant))
          .toList(),
      privacySettings: GrowPrivacy.fromJson(json['privacySettings']),
    );
  }
}
