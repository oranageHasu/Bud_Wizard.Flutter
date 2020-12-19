import 'dart:ui';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/growDetail.dart';
import 'package:bud_wizard/widgets/grow/growSelector.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/plantDetail.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';

class GrowPageBody extends StatelessWidget {
  final Future<List<Grow>> _grows;
  final Grow _currentGrow;
  final Plant _currentPlant;

  GrowPageBody({
    @required Future<List<Grow>> grows,
    @required Grow currentGrow,
    @required Plant currentPlant,
  })  : this._grows = grows,
        this._currentGrow = currentGrow,
        this._currentPlant = currentPlant;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Grow>>(
            future: _grows,
            builder: (context, snapshot) {
              Grow currentGrow;
              Widget retval = loading();

              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  retval = noData();
                } else {
                  if (_currentGrow == null) {
                    currentGrow = snapshot.data[0];
                  } else {
                    currentGrow = _currentGrow;
                  }

                  retval = GrowSelector(
                    grows: snapshot.data,
                    currentGrow: currentGrow,
                  );
                }
              } else if (snapshot.hasError) {
                return NoDataError();
              }

              return retval;
            },
          ),
          Expanded(
            child: (_currentPlant != null)
                ? PlantDetail(plant: _currentPlant)
                : GrowDetail(
                    grows: _grows,
                    currentGrow: _currentGrow,
                  ),
          ),
          Container(
            width: 400.0,
            child: Column(
              children: [
                DankLabel(
                  displayText: 'Recent Activity',
                  textStyle: appLabelFontStyle.copyWith(
                    color: appHintTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                  width: 375.0,
                  textAlign: TextAlign.center,
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                ),
                Card(
                  clipBehavior: Clip.hardEdge,
                  elevation: 0.0,
                  color: appSecondColor,
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    height: 100.0,
                    width: 375.0,
                    child: Column(
                      children: [
                        DankLabel(
                          displayText: 'it\'s quiet for now...',
                          textStyle: appLabelFontStyle.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                        ),
                        DankLabel(
                          displayText:
                              'When a grow related activity occurs - like another grower answering a question' +
                                  ' or visiting your grow - we\'ll show it here!',
                          textStyle: appInputHintFontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: 320.0,
          margin: EdgeInsets.all(10.0),
          child: DankLoading(),
        ),
      ],
    );
  }

  Widget noData() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: 320.0,
          margin: EdgeInsets.all(10.0),
          child: DankLabel(
            displayText: 'No Data Found',
            textStyle: appInputHintFontStyle.copyWith(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            padding: EdgeInsets.only(
              top: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
