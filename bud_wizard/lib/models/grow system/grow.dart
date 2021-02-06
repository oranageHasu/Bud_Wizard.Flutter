import 'dart:convert';
import 'package:bud_wizard/models/grow%20system/growLight.dart';
import 'package:bud_wizard/models/grow%20system/growPrivacy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';

class Grow {
  final Guid growId;
  final Guid userId;
  String name = '<no name>';
  DateTime startDate = DateTime.now();
  GrowSetting setting = GrowSetting.Indoor;
  bool isDeleted;
  List<GrowLight> growLights = [];
  List<Plant> plants;
  GrowPrivacy privacySettings;

  Grow({
    @required Guid growId,
    @required Guid userId,
    @required List<Plant> plants,
    @required GrowPrivacy privacySettings,
    @required bool isDeleted,
  })  : this.growId = growId,
        this.userId = userId,
        this.isDeleted = isDeleted,
        this.plants = plants,
        this.privacySettings = privacySettings;

  factory Grow.fromJson(Map<String, dynamic> json) {
    Grow grow = Grow(
      growId: Guid(json['growId']),
      userId: Guid(json['userId']),
      isDeleted: json['isDeleted'],
      plants: (json['plants'] as List)
          .map((plant) => Plant.fromJson(plant))
          .toList(),
      privacySettings: GrowPrivacy.fromJson(
        jsonDecode(json['privacySettings']),
      ),
    );

    print('we got a grow');
    grow.name = json['name'];
    grow.startDate = DateTime.parse(json['startDate']);
    grow.setting =
        GrowSetting.values.firstWhere((e) => e.index == json['setting'] as int);
    /*
    grow.growLights = (json['growLights'] as List)
        .map((growLight) => GrowLight.fromJson(growLight))
        .toList();*/

    return grow;
  }

  Map<String, dynamic> toJson() {
    print(privacySettings.toJson());
    return {
      if (growId != null) 'growId': growId.toString() else 'growId': null,
      'userId': userId.toString(),
      'isDeleted': isDeleted,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'growLights': jsonEncode(
          growLights.map((growLight) => growLight.toJson()).toList()),
      'privacySettings': jsonEncode(privacySettings.toJson()),
      //'plants': jsonEncode(plants.map((plant) => plant.toJson()).toList()),
    };
  }
}
