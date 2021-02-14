import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/plant/plantSummaryCard.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/dankBounceTransition.dart';
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
            width: 320.0,
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
                Container(
                  height: 50.0,
                  width: 50.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Image.asset(
                    (widget.grow.plants.isNotEmpty &&
                            widget.grow.plants[0].imagePath != null)
                        ? widget.grow.plants[0].imagePath
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
                          displayText: widget.grow.name,
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
                          displayText:
                              widget.grow.plants.length.toString() + ' Plants',
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

  Widget _plants() {
    return DankBounceTransition(
      slideType: SlideTransitionType.SlideDown,
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

  void _selectGrow() {
    GrowPage.of(context).setCurrentGrow(widget.grow);
  }
}
