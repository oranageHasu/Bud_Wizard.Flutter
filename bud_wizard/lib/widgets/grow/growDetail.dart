import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/plantSelector.dart';
import 'package:flutter/material.dart';

class GrowDetail extends StatelessWidget {
  final Future<List<Grow>> _grows;
  final Grow _currentGrow;

  GrowDetail({
    Future<List<Grow>> grows,
    Grow currentGrow,
  })  : this._grows = grows,
        this._currentGrow = currentGrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appSecondColor,
      child: FutureBuilder<List<Grow>>(
        future: _grows,
        builder: (context, snapshot) {
          Grow currentGrow;
          Widget retval = SizedBox.shrink();

          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              if (_currentGrow == null) {
                currentGrow = snapshot.data[0];
              } else {
                currentGrow = _currentGrow;
              }

              retval = PlantSelector(
                grow: currentGrow,
              );
            }
          } else if (snapshot.hasError) {
            return NoDataError();
          }

          return retval;
        },
      ),
    );
  }
}
