import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:flutter/material.dart';

class DankCheckbox extends StatelessWidget {
  final Function(bool) onChanged;
  final EdgeInsets margin;
  final String tooltipText;
  final bool isDisabled;
  final bool value;

  DankCheckbox({
    @required onChanged,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    String tooltipText = '',
    bool isDisabled = false,
    bool value = false,
  })  : this.onChanged = onChanged,
        this.margin = margin,
        this.tooltipText = tooltipText,
        this.isDisabled = isDisabled,
        this.value = value;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: appSecondColor,
      ),
      child: DankTooltip(
        tooltipText: tooltipText,
        displayTooltip: false,
        child: Container(
          padding: const EdgeInsets.all(0.0),
          width: 20.0,
          child: Checkbox(
            value: value,
            checkColor: appBaseColor,
            activeColor: Colors.transparent,
            splashRadius: 0.0,
            onChanged: (isDisabled) ? null : onChanged,
          ),
        ),
      ),
    );
  }
}
