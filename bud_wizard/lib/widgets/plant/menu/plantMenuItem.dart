import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantMenuItem extends StatefulWidget {
  final String displayText;
  final String tooltipText;
  final bool isSelected;
  final Function(PlantOperation) onSelected;
  final PlantOperation opType;

  PlantMenuItem({
    @required String displayText,
    @required String tooltipText,
    @required Function(PlantOperation) onSelected,
    @required PlantOperation opType,
    bool isSelected = false,
  })  : this.displayText = displayText,
        this.tooltipText = tooltipText,
        this.onSelected = onSelected,
        this.opType = opType,
        this.isSelected = isSelected;

  @override
  _PlantMenuItemState createState() => _PlantMenuItemState(
        this.displayText,
        this.tooltipText,
        this.onSelected,
        this.opType,
        this.isSelected,
      );
}

class _PlantMenuItemState extends State<PlantMenuItem> {
  String displayText;
  String tooltipText;
  Function(PlantOperation) onSelected;
  PlantOperation opType;
  bool isSelected;
  bool _isHovered = false;

  _PlantMenuItemState(
    this.displayText,
    this.tooltipText,
    this.onSelected,
    this.opType,
    this.isSelected,
  );

  @override
  void didUpdateWidget(PlantMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return DankTooltip(
      tooltipText: tooltipText,
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
          onTap: () => {
            if (onSelected != null) {onSelected(opType)}
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DankLabel(
                  displayText: displayText,
                  textStyle: (isSelected || _isHovered)
                      ? appLabelFontStyle
                      : appLabelFontStyle.copyWith(
                          color: appHintTextColor,
                        ),
                  textAlign: TextAlign.center,
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0),
                ),
                Container(
                  height: 3.0,
                  width: (isSelected) ? 100.0 : 0.0,
                  color: appBaseColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
