import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant%20system/plant.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/plantSummaryCard.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GrowCard extends StatefulWidget {
  final Grow grow;
  final Plant currentPlant;
  final String tooltipText;
  final bool isSelected;

  GrowCard({
    Key key,
    @required Grow grow,
    @required Plant currentPlant,
    @required String tooltipText,
    bool isSelected = false,
  })  : this.grow = grow,
        this.currentPlant = currentPlant,
        this.tooltipText = tooltipText,
        this.isSelected = isSelected,
        super(key: key);

  @override
  _GrowsCardState createState() => _GrowsCardState();
}

class _GrowsCardState extends State<GrowCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _growInfo(),
        if (widget.isSelected) _plants(),
      ],
    );
  }

  Widget _growInfo() {
    return DankTooltip(
      tooltipText: widget.tooltipText,
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
          onTap: _selectGrow,
          child: Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(
              top: 5.0,
              left: 5.0,
              right: 5.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
              color: _determineColor(),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(35.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DankLabel(
                          displayText: widget.grow.name,
                          textAlign: TextAlign.start,
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
                          displayText: widget.grow.plants.length.toString() +
                              _getPlantCountText(),
                          textAlign: TextAlign.start,
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

  Widget _plants() {
    return FadeIn(
      duration: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (Plant plant in widget.grow.plants)
            PlantSummaryCard(
              plant: plant,
              isSelected: widget.currentPlant == plant,
            ),
        ],
      ),
      isVisible: true,
    );
  }

  Color _determineColor() {
    Color retval;

    if (_isHovered && !widget.isSelected) {
      retval = Colors.grey.withOpacity(0.05);
    } else if (widget.isSelected) {
      retval = Colors.grey.withOpacity(0.15);
    } else {
      retval = Colors.transparent;
    }

    return retval;
  }

  String _getPlantCountText() {
    return (widget.grow.plants.length == 1) ? ' Plant' : ' Plants';
  }

  void _selectGrow() {
    GrowPage.of(context).setCurrentGrow(widget.grow);
  }
}
