import 'package:flutter/foundation.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';

class Plant {
  final Guid plantId;
  final Guid growId;
  final DateTime startDate;
  String name;
  String strain;
  GeneticType genetics;
  Gender sex;
  GrowState growthState;
  String imagePath;

  Plant({
    @required Guid plantId,
    @required Guid growId,
    @required DateTime startDate,
    GeneticType genetics = GeneticType.Hybrid,
    Gender sex = Gender.Unknown,
    GrowState growthState = GrowState.Germination,
    String name,
    String strain,
  })  : this.plantId = plantId,
        this.growId = growId,
        this.genetics = genetics,
        this.sex = sex,
        this.growthState = growthState,
        this.name = name,
        this.startDate = startDate,
        this.strain = strain;

  factory Plant.fromJson(Map<String, dynamic> json) {
    Plant plant = Plant(
      plantId: new Guid(json['plantId']),
      growId: new Guid(json['growId']),
      name: json['name'],
      strain: json['strain'],
      startDate: DateTime.parse(json['startDate']),
      genetics: GeneticType.values
          .firstWhere((e) => e.index == json['genetics'] as int),
      sex: Gender.values.firstWhere((e) => e.index == json['sex'] as int),
      growthState: GrowState.values
          .firstWhere((e) => e.index == json['growthState'] as int),
    );

    // Stubbed in for testing
    switch (plant.strain) {
      case 'Afghan Kush':
        plant.imagePath = 'afghan.jpg';
        break;
      case 'Cotton Candy':
        plant.imagePath = 'cotton-candy.jpg';
        break;
      case 'White Widow':
        plant.imagePath = 'white-widow.jpg';
        break;
      case 'Panama Red':
        plant.imagePath = 'panama-red.jpg';
        break;
      case 'Black Widow':
        plant.imagePath = 'black-widow.jpg';
        break;
      case 'Strawberry Cough':
        plant.imagePath = 'strawberry-cough.jpg';
        break;
      case 'Dark Angel':
        plant.imagePath = 'dark-angel.jpg';
        break;
    }

    return plant;
  }

  Map<String, dynamic> toJson() {
    return {
      if (plantId != null) 'plantId': plantId.toString() else 'plantId': null,
      'growId': growId.toString(),
      'name': name,
      'strain': strain,
      'startDate': startDate.toIso8601String(),
      'genetics': genetics.index,
      'sex': sex.index,
      'growthState': growthState.index,
    };
  }

  String getGenderIcon() {
    String retval = '';

    switch (this.sex) {
      case Gender.Male:
        retval = 'male.png';
        break;
      case Gender.Female:
        retval = 'female.png';
        break;
      case Gender.Hermaphrodite:
        retval = 'hermi.png';
        break;
      case Gender.Unknown:
        retval = 'hermi.png';
        break;
    }

    return retval;
  }

  String seedRetailer() {
    return 'Crop Kings Seeds';
  }
}
