import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/widgets/grow/growsPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GrowCard extends StatefulWidget {
  final Grow grow;
  final String tooltipText;
  final bool isSelected;

  GrowCard({
    Key key,
    @required Grow grow,
    @required String tooltipText,
    bool isSelected = false,
  })  : this.grow = grow,
        this.tooltipText = tooltipText,
        this.isSelected = isSelected,
        super(key: key);

  @override
  _GrowsCardState createState() => _GrowsCardState(
        this.grow,
        this.tooltipText,
        this.isSelected,
      );
}

class _GrowsCardState extends State<GrowCard> {
  Grow grow;
  String tooltipText;
  bool isSelected;
  bool isHovered = false;

  _GrowsCardState(
    this.grow,
    this.tooltipText,
    this.isSelected,
  );

  @override
  void didUpdateWidget(GrowCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.grow != widget.grow) {
      grow = widget.grow;
    }

    if (oldWidget.isSelected != widget.isSelected) {
      isSelected = widget.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: tooltipText,
      displayTooltip: isHovered,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (value) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            isHovered = false;
          });
        },
        child: InkWell(
          onTap: selectGrow,
          child: Container(
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
              color: determineColor(),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  margin: EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                    grow.plants[0].imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(35.0)),
                    child: DankLabel(
                      displayText: grow.name,
                      textAlign: TextAlign.start,
                      padding: EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 7.0,
                        bottom: 7.0,
                      ),
                      textStyle: appLabelFontStyle.copyWith(
                        color: (isHovered || isSelected)
                            ? appBaseWhiteTextColor
                            : appBaseWhiteTextColor.withOpacity(0.5),
                      ),
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

  Color determineColor() {
    Color retval;

    if (isHovered && !isSelected) {
      retval = Colors.grey.withOpacity(0.05);
    } else if (isSelected) {
      retval = Colors.grey.withOpacity(0.15);
    } else {
      retval = Colors.transparent;
    }

    return retval;
  }

  void selectGrow() {
    // Tell the parent its data has changed and force a re-render
    GrowsPage.of(context).setCurrentGrow(grow);
  }
}
