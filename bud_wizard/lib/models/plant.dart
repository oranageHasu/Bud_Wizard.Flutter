import 'dart:ui';

import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:bud_wizard/classes/enumerations.dart';

class Plant {
  final Guid plantId;
  Guid growId;
  String name;
  DateTime startDate;
  String strain;
  GeneticType genetics;
  Gender sex;
  GrowState growthState;
  String imagePath;

  Plant({
    this.plantId,
    this.growId,
    this.name,
    this.startDate,
    this.strain,
    this.genetics,
    this.sex,
    this.growthState,
  });

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
    print('gender icon string: ' + retval);

    return retval;
  }

  Color getGrowthStateColor() {
    Color retval = appBaseWhiteTextColor;

    switch (this.growthState) {
      case GrowState.Germination:
        retval = Color.fromRGBO(102, 75, 0, 1.0);
        break;
      case GrowState.Vegatative:
        retval = appBaseColor;
        break;
      case GrowState.Flowering:
        retval = Color.fromRGBO(222, 203, 0, 1.0);
        break;
      case GrowState.Drying:
        retval = Color.fromRGBO(222, 170, 0, 1.0);
        break;
      case GrowState.Curing:
        retval = Color.fromRGBO(222, 93, 0, 1.0);
        break;
    }

    return retval;
  }
}
