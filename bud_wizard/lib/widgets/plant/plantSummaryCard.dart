import 'dart:ui';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantSummaryCard extends StatefulWidget {
  final Plant plant;
  final bool isSelected;

  PlantSummaryCard({
    @required Plant plant,
    bool isSelected = false,
  })  : this.plant = plant,
        this.isSelected = isSelected;

  @override
  _PlantSummaryCardState createState() => _PlantSummaryCardState();
}

class _PlantSummaryCardState extends State<PlantSummaryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: 'Click to view this plant',
      displayTooltip: _isHovered,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
        child: InkWell(
          onTap: () {
            if (!widget.isSelected) {
              _selectPlant(widget.plant);
            }
          },
          child: Container(
            width: 250.0,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(
              top: 5.0,
              left: 5.0,
              right: 5.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.transparent,
              border: Border.all(
                color: _determineColor(widget.plant),
                width: 2.0,
              ),
              boxShadow: (widget.isSelected)
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        blurRadius: 25.0,
                        spreadRadius: 20.0,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Image.asset(
                    (widget.plant.imagePath != null)
                        ? widget.plant.imagePath
                        : 'grow/img1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(35.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DankLabel(
                          displayText: widget.plant.name,
                          textAlign: TextAlign.start,
                          padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          textStyle: appLabelFontStyle.copyWith(
                            color: (_isHovered || widget.isSelected)
                                ? Theme.of(context).textTheme.bodyText1.color
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color
                                    .withOpacity(0.5),
                          ),
                        ),
                        DankLabel(
                          displayText: widget.plant.strain,
                          textAlign: TextAlign.start,
                          padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          textStyle: appInputHintFontStyle.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .color
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _determineColor(Plant plant) {
    Color retval;

    if (_isHovered && !widget.isSelected) {
      retval = Theme.of(context).primaryColor.withOpacity(0.15);
    } else if (widget.isSelected) {
      retval = Theme.of(context).primaryColor.withOpacity(0.8);
    } else {
      retval = Colors.transparent;
    }

    return retval;
  }

  void _selectPlant(Plant plant) {
    GrowPage.of(context).setCurrentPlant(plant);
  }
}
