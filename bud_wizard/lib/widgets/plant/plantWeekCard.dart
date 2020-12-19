import 'dart:ui';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantWeekCard extends StatefulWidget {
  final String displayText;
  final Color cardColor;
  final int weekNumber;
  final bool colorTransition;

  PlantWeekCard({
    String displayText,
    Color cardColor,
    int weekNumber,
    bool colorTransition = false,
  })  : this.displayText = displayText,
        this.cardColor = cardColor,
        this.weekNumber = weekNumber,
        this.colorTransition = colorTransition;

  @override
  _PlantWeekCardState createState() => _PlantWeekCardState(
        this.displayText,
        this.cardColor,
        this.weekNumber,
        this.colorTransition,
      );
}

class _PlantWeekCardState extends State<PlantWeekCard> {
  String displayText;
  Color cardColor;
  int weekNumber;
  bool colorTransition;
  bool isHovered = false;

  _PlantWeekCardState(
    this.displayText,
    this.cardColor,
    this.weekNumber,
    this.colorTransition,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantWeekCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 76,
          width: 55.0,
          margin: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            gradient: getLinearGradient(
              colorTransition,
              cardColor,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.5),
            child: Container(
              height: 70.0,
              width: 55.0,
              decoration: BoxDecoration(
                color: appThirdColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: cardColor,
                      gradient: getLinearGradient(
                        colorTransition,
                        cardColor,
                      ),
                    ),
                    child: DankLabel(
                      displayText: displayText,
                      textStyle: appPlantWeekFontStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(4.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            DankLabel(
                              displayText: weekNumber.toString(),
                              textStyle: appPlantWeekFontStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            DankLabel(
                              displayText: 'Week',
                              textStyle: appPlantWeekFontStyle.copyWith(
                                fontSize: 13.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(2.5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                hoverColor: Colors.black.withOpacity(0.4),
                splashColor: Colors.black.withOpacity(0.4),
                onTap: () => {selectPlantWeek()},
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectPlantWeek() {
    print('To Do: Select Plant Week.');
  }

  LinearGradient getLinearGradient(
    bool colorTransition,
    Color color,
  ) {
    Color transitionToColor;

    if (colorTransition) {
      if (color == growGerminationColor) {
        transitionToColor = growVegetativeColor;
      } else if (color == growVegetativeColor) {
        transitionToColor = growFloweringColor;
      } else if (color == growFloweringColor) {
        transitionToColor = growDryingColor;
      } else if (color == growDryingColor) {
        transitionToColor = growCuringColor;
      }

      return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [color, transitionToColor]);
    } else {
      return LinearGradient(colors: [color, color]);
    }
  }
}
