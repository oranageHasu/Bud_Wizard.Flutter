import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantInfoItem extends StatelessWidget {
  final Plant plant;
  final String imageUrl;
  final String headerText;
  final String subText;

  PlantInfoItem({
    Plant plant,
    String imageUrl,
    String headerText,
    String subText,
  })  : this.plant = plant,
        this.imageUrl = imageUrl,
        this.headerText = headerText,
        this.subText = subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            color: Colors.transparent,
            margin: EdgeInsets.only(right: 15.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.scaleDown,
              color: appBaseColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DankLabel(
                displayText: headerText,
                textStyle: appPlantDetailStyle,
              ),
              DankLabel(
                displayText: subText,
                textStyle: appPlantDetailStyle.copyWith(
                  color: appBaseWhiteTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
