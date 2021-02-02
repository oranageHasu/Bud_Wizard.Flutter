import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/plantInfoItem.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantInfo extends StatelessWidget {
  final Plant plant;
  final bool isFeatured;

  PlantInfo({
    Plant plant,
    bool isFeatured = true,
  })  : this.plant = plant,
        this.isFeatured = isFeatured;

  @override
  Widget build(BuildContext context) {
    return (isFeatured)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DankLabel(
                      displayText: plant.strain,
                      textStyle: appHeaderFontStyle.copyWith(
                        fontSize: 30.0,
                      ),
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          plant.getGenderIcon(),
                          fit: BoxFit.scaleDown,
                          height: 50.0,
                          width: 50.0,
                        ),
                        DankLabel(
                          displayText: formatEnum(plant.growthState.toString()),
                          textStyle: appPlantDetailStyle.copyWith(
                            color: getGrowthStateColor(plant.growthState),
                            fontSize: 28.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlantInfoItem(
                    plant: plant,
                    imageUrl: 'seeds.png',
                    headerText: plant.strain,
                    subText: plant.seedRetailer(),
                  ),
                  PlantInfoItem(
                    plant: plant,
                    imageUrl: 'nutrients.png',
                    headerText: 'Advanced Nutrients',
                    subText: 'Nutrients',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlantInfoItem(
                    plant: plant,
                    imageUrl: 'light.png',
                    headerText: '200 Watts',
                    subText: 'LED',
                  ),
                  PlantInfoItem(
                    plant: plant,
                    imageUrl: 'clock.png',
                    headerText: '12 hr/12 hr',
                    subText: 'Light Schedule',
                  ),
                ],
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DankLabel(
                  displayText: plant.strain,
                  textStyle: appHeaderFontStyle.copyWith(
                    fontSize: (isFeatured) ? 35.0 : 18.0,
                  ),
                  padding: EdgeInsets.only(left: 10.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    plant.getGenderIcon(),
                    fit: BoxFit.scaleDown,
                    height: 50.0,
                    width: 50.0,
                  ),
                  DankLabel(
                    displayText: formatEnum(plant.growthState.toString()),
                    textStyle: appPlantDetailStyle.copyWith(
                      color: getGrowthStateColor(plant.growthState),
                      fontSize: (isFeatured) ? 28.0 : 18.0,
                    ),
                    padding: EdgeInsets.only(right: 25.0),
                  ),
                ],
              ),
            ],
          );
  }
}
