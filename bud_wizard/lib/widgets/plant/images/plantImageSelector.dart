import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantImageSelector extends StatelessWidget {
  final Plant plant;

  PlantImageSelector({
    Plant plant,
  }) : this.plant = plant;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 150.0,
        padding: EdgeInsets.only(
          left: 2.0,
          right: 2.0,
          top: 10.0,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            PlantImageContainer(imgPath: 'grow/img1.jpg'),
            PlantImageContainer(imgPath: 'grow/img2.jpg'),
            PlantImageContainer(imgPath: 'grow/img3.jpg'),
            PlantImageContainer(imgPath: 'grow/img11.jpg'),
            PlantImageContainer(imgPath: 'grow/img12.jpg'),
            PlantImageContainer(imgPath: 'grow/img4.jpg'),
            PlantImageContainer(imgPath: 'grow/img5.jpg'),
            PlantImageContainer(imgPath: 'grow/img6.jpg'),
            PlantImageContainer(imgPath: 'grow/img7.jpg'),
          ],
        ),
      ),
    );
  }
}
