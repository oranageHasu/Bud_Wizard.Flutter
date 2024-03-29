import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/add/addFirstPlant.dart';
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
      color: (currentTheme.currentTheme() == ThemeMode.dark)
          ? appDarkSecondaryColor
          : appLightSecondaryColor,
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

              if (currentGrow.plants.isEmpty) {
                retval = AddFirstPlant();
              }
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
