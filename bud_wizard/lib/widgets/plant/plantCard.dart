import 'dart:ui';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/plantInfo.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final bool isFeatured;
  final bool isLeftSide;
  final bool isSelectable;

  PlantCard({
    Plant plant,
    bool isFeatured = false,
    bool isLeftSide = false,
    bool isSelectable = true,
  })  : this.plant = plant,
        this.isFeatured = isFeatured,
        this.isLeftSide = isLeftSide,
        this.isSelectable = isSelectable;

  @override
  Widget build(BuildContext context) {
    double cardPadding = 10.0;

    return Card(
      elevation: 15.0,
      clipBehavior: Clip.hardEdge,
      margin: (isFeatured)
          ? EdgeInsets.all(cardPadding)
          : EdgeInsets.only(
              left: (!isLeftSide) ? cardPadding / 2 : cardPadding,
              right: (isLeftSide) ? cardPadding / 2 : cardPadding,
              bottom: cardPadding,
            ),
      child: Stack(
        children: [
          Container(
            height: (isFeatured) ? 400.0 : 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: (isFeatured) ? 400.0 : 300.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Image.asset(
                    plant.imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: (isFeatured) ? 300.0 : 250.0,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            height: (isFeatured) ? 120.0 : 50.0,
                            color: Colors.black.withOpacity(0.7),
                            child: PlantInfo(
                              plant: plant,
                              isFeatured: isFeatured,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isSelectable)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  hoverColor: Colors.black.withOpacity(0.2),
                  splashColor: Colors.black.withOpacity(0.2),
                  onTap: () => {selectPlant(context)},
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
