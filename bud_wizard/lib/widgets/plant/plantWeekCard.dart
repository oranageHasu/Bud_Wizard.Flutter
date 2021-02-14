import 'dart:ui';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournal.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantWeekCard extends StatefulWidget {
  final String displayText;
  final Color cardColor;
  final int weekNumber;
  final bool colorTransition;
  final bool isSelected;

  PlantWeekCard({
    @required bool isSelected,
    @required String displayText,
    @required Color cardColor,
    @required int weekNumber,
    bool colorTransition = false,
  })  : this.displayText = displayText,
        this.cardColor = cardColor,
        this.weekNumber = weekNumber,
        this.colorTransition = colorTransition,
        this.isSelected = isSelected;

  @override
  _PlantWeekCardState createState() => _PlantWeekCardState();
}

class _PlantWeekCardState extends State<PlantWeekCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 65.0,
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                gradient: getLinearGradient(
                  widget.colorTransition,
                  widget.cardColor,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Container(
                  width: 65.0,
                  decoration: BoxDecoration(
                    color: (currentTheme.currentTheme() == ThemeMode.dark)
                        ? appDarkTertiaryColor
                        : appLightTertiaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                          color: widget.cardColor,
                          gradient: getLinearGradient(
                            widget.colorTransition,
                            widget.cardColor,
                          ),
                        ),
                        child: DankLabel(
                          displayText: widget.displayText,
                          textStyle: appPlantWeekFontStyle.copyWith(
                            color: appBaseWhiteTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            padding: EdgeInsets.all(4.5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DankLabel(
                                  displayText: 'Week',
                                  textStyle: appPlantWeekFontStyle.copyWith(
                                    fontSize: 13.5,
                                  ),
                                ),
                                DankLabel(
                                  displayText: widget.weekNumber.toString(),
                                  textStyle: appPlantWeekFontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
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
            Container(
              height: 4.0,
              width: (_isHovered && !widget.isSelected) ? 25.0 : 55.0,
              decoration: BoxDecoration(
                gradient: (_isHovered || widget.isSelected)
                    ? getLinearGradient(
                        widget.colorTransition,
                        widget.cardColor,
                      )
                    : null,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 6,
                left: 2.5,
                right: 2.5,
                top: 2.5,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                hoverColor: Colors.black.withOpacity(0.4),
                splashColor: Colors.black.withOpacity(0.4),
                onTap: selectPlantWeek,
                child: MouseRegion(
                  onEnter: (value) {
                    setState(() {
                      _isHovered = true;
                    });
                  },
                  onExit: (value) {
                    setState(() {
                      _isHovered = false;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectPlantWeek() {
    // Tell the parent its data has changed and force a re-render
    PlantJournal.of(context).setCurrentWeek(widget.weekNumber);
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
