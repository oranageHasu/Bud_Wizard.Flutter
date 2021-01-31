import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/add/addGrow.dart';
import 'package:bud_wizard/widgets/grow/growActivity.dart';
import 'package:bud_wizard/widgets/grow/growDetail.dart';
import 'package:bud_wizard/widgets/grow/growSelector.dart';
import 'package:bud_wizard/widgets/grow/myFirstGrow.dart';
import 'package:bud_wizard/widgets/plant/plantDetail.dart';
import 'package:flutter/material.dart';

class GrowPageBody extends StatelessWidget {
  final Future<List<Grow>> _grows;
  final Grow _currentGrow;
  final Plant _currentPlant;
  final PlantOperation _currentPlantOp;
  final GrowOperation _currentGrowOp;

  GrowPageBody({
    @required Future<List<Grow>> grows,
    @required Grow currentGrow,
    @required Plant currentPlant,
    @required PlantOperation currentPlantOp,
    @required GrowOperation currentGrowOp,
  })  : this._grows = grows,
        this._currentGrow = currentGrow,
        this._currentPlant = currentPlant,
        this._currentPlantOp = currentPlantOp,
        this._currentGrowOp = currentGrowOp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<List<Grow>>(
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

                  retval = GrowSelector(
                    grows: snapshot.data,
                    currentGrow: currentGrow,
                  );
                }
              }

              return retval;
            },
          ),
          Expanded(
            child: _getBody(),
          ),
          (_currentPlant != null &&
                  _currentPlantOp != PlantOperation.Statistics)
              ? GrowActivity()
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _getBody() {
    Widget retval = SizedBox.shrink();

    if (_currentPlant != null) {
      retval = PlantDetail(
        plant: _currentPlant,
        operation: _currentPlantOp,
      );
    } else if (_currentGrow != null) {
      retval = GrowDetail(
        grows: _grows,
        currentGrow: _currentGrow,
      );
    } else if (_currentGrowOp == GrowOperation.AddGrow) {
      retval = AddGrow();
    } else {
      retval = MyFirstGrow();
    }

    return retval;
  }
}
