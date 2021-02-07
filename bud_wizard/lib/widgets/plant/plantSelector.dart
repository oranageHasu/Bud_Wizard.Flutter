import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        : _addFirstPlant(context);
  }

  Widget _addFirstPlant(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: 2500,
            delay: Duration(milliseconds: 500),
            child: DankLabel(
              displayText: 'Thanks for starting a grow with us...',
              textStyle: GoogleFonts.architectsDaughter(
                fontSize: 35.0,
              ),
              padding: EdgeInsets.only(top: 10.0),
            ),
            isVisible: true,
          ),
          FadeIn(
            duration: 2500,
            delay: Duration(milliseconds: 2000),
            child: Column(
              children: [
                DankLabel(
                  displayText: 'Start by adding your first plant',
                  textStyle: GoogleFonts.architectsDaughter(
                    fontSize: 35.0,
                  ),
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: appBaseColor.withOpacity(0.3),
                        blurRadius: 35.0,
                        spreadRadius: 15.0,
                      ),
                    ],
                  ),
                  child: DankButton(
                    buttonType: DankButtonType.Flat,
                    buttonText: 'Add Plant',
                    textStyle: appLabelFontStyle.copyWith(fontSize: 25.0),
                    borderRadius: 5.0,
                    padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
                      left: 35.0,
                      right: 35.0,
                    ),
                    onPressed: () {
                      GrowPage.of(context).startNewPlant();
                    },
                  ),
                ),
              ],
            ),
            isVisible: true,
          ),
        ],
      ),
    );
  }
}
