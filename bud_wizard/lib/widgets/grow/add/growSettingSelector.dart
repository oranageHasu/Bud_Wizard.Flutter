import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-radio-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GrowSettingSelector extends StatefulWidget {
  final Grow grow;
  final Function(GrowSetting) selectionChanged;

  GrowSettingSelector({
    @required Grow grow,
    @required Function(GrowSetting) selectionChanged,
  })  : this.selectionChanged = selectionChanged,
        this.grow = grow;

  @override
  _GrowSettingSelectorState createState() => _GrowSettingSelectorState();
}

class _GrowSettingSelectorState extends State<GrowSettingSelector> {
  int _currentLocation = 0;

  @override
  void initState() {
    if (widget.grow != null) {
      _currentLocation = widget.grow.setting.index;
    }

    super.initState();
  }

  @override
  void didUpdateWidget(GrowSettingSelector oldWidget) {
    if (widget.grow != null) {
      _currentLocation = widget.grow.setting.index;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DankLabel(
          displayText: 'Grow Location:',
          textStyle: appLabelFontStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
          padding: EdgeInsets.only(bottom: 5.0),
        ),
        Row(
          children: [
            Container(
              width: 15.0,
            ),
            DankRadioButton(
              id: GrowSetting.Indoor.index,
              currentIndex: _currentLocation,
              displayText: 'Indoors',
              onTapped: _selectionChanged,
            ),
            Container(
              width: 15.0,
            ),
            DankRadioButton(
              id: GrowSetting.Outdoor.index,
              currentIndex: _currentLocation,
              displayText: 'Outdoors',
              onTapped: _selectionChanged,
            ),
          ],
        ),
      ],
    );
  }

  void _selectionChanged(int value) {
    setState(() {
      _currentLocation = value;
    });

    widget.selectionChanged(
      GrowSetting.values.firstWhere((e) => e.index == value),
    );
  }
}
