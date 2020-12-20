import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/plantInfoItem.dart';
import 'package:flutter/material.dart';

class PlantInfo extends StatelessWidget {
  final Plant plant;

  PlantInfo({
    Plant plant,
  }) : this.plant = plant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlantInfoItem(
          plant: plant,
          imageUrl: 'seeds.png',
          headerText: plant.strain,
          subText: plant.seedRetailer(),
        ),
        PlantInfoItem(
          plant: plant,
          imageUrl: 'light.png',
          headerText: '200 Watts',
          subText: 'LED',
        ),
      ],
    );
  }
}
