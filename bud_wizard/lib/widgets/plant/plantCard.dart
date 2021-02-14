import 'dart:ui';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/plantInfo.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  PlantCard({
    Plant plant,
  }) : this.plant = plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      constraints: BoxConstraints(maxWidth: 1000.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Image.asset(
                plant.imagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          height: 120.0,
                          color: Colors.black.withOpacity(0.7),
                          child: PlantInfo(
                            plant: plant,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectPlant(BuildContext context) {
    // Tell the parent its data has changed and force a re-render
    GrowPage.of(context).setCurrentPlant(plant);
  }
}
