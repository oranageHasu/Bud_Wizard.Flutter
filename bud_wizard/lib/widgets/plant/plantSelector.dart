import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:flutter/material.dart';

class PlantSelector extends StatelessWidget {
  final Grow grow;

  PlantSelector({
    Grow grow,
  }) : this.grow = grow;

  @override
  Widget build(BuildContext context) {
    return (grow.plants.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PlantCard(
                plant: grow.plants[0],
                isFeatured: true,
              ),
              Row(
                children: [
                  if (grow.plants.length > 1)
                    Expanded(
                      child: PlantCard(
                        plant: grow.plants[1],
                        isLeftSide: true,
                      ),
                    ),
                  (grow.plants.length > 2)
                      ? Expanded(
                          child: PlantCard(
                            plant: grow.plants[2],
                          ),
                        )
                      : Expanded(child: SizedBox(height: 300.0)),
                ],
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
