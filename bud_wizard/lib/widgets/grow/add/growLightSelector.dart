import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/grow%20system/growLight.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-chip.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GrowLightSelector extends StatefulWidget {
  final Grow grow;
  final Function(List<GrowLight>) selectionChanged;

  GrowLightSelector({
    @required Grow grow,
    @required Function(List<GrowLight>) selectionChanged,
  })  : this.selectionChanged = selectionChanged,
        this.grow = grow;

  @override
  _GrowLightSelectorState createState() => _GrowLightSelectorState();
}

class _GrowLightSelectorState extends State<GrowLightSelector> {
  @override
  void initState() {
    if (widget.grow != null) {}

    super.initState();
  }

  @override
  void didUpdateWidget(GrowLightSelector oldWidget) {
    if (widget.grow != null) {}

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      width: 520.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DankLabel(
                displayText: 'Lighting:',
                textStyle: appLabelFontStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              DankTextField(
                labelText: 'Search',
                hintText: 'Search by brand, model, etc.',
                maxWidth: 300.0,
                margin: EdgeInsets.only(
                  bottom: 8.0,
                ),
                textPadding: EdgeInsets.all(2.5),
                prefixIcon: Icon(
                  Icons.search,
                  color: appBaseWhiteTextColor,
                  size: 20.0,
                ),
                onChanged: (String value) {
                  print('To Do: Search Lights');
                },
              ),
            ],
          ),
          Row(
            children: [
              DankChip(
                onTapped: removeLight,
                label: DankLabel(
                  displayText: 'spider farmer sf1000',
                  textStyle: appLabelFontStyle.copyWith(
                    fontSize: 12.0,
                    color: appBaseWhiteTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DankChip(
                onTapped: removeLight,
                label: DankLabel(
                  displayText: 'spider farmer sf2000',
                  textStyle: appLabelFontStyle.copyWith(
                    fontSize: 12.0,
                    color: appBaseWhiteTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void removeLight() {
    print('To Do: Remove Light');
  }
}
