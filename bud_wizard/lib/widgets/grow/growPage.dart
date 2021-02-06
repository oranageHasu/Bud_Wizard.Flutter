import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api%20services/api-grow.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/grow/growPageBody.dart';
import 'package:bud_wizard/widgets/grow/growPageHeader.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-validation-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class GrowPage extends StatefulWidget {
  static GrowPageState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GrowWidget>().growsData;
  }

  @override
  State<StatefulWidget> createState() => GrowPageState();
}

class GrowPageState extends State<GrowPage> {
  Future<List<Grow>> _grows;
  Grow _currentGrow;
  Plant _currentPlant;
  PlantOperation _currentPlantOp = PlantOperation.Journal;
  GrowOperation _currentGrowOp = GrowOperation.EditGrows;

  @override
  void initState() {
    _grows =
        getGrows(new Guid('77c1e2cb-6792-4acd-ae31-3ab61a150822')).then((data) {
      if (data != null && data.length >= 1) {
        setCurrentGrow(data[0]);
      }

      return data;
    }, onError: (e) {
      log(e);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DankNavigator(
      currentScreen: Screen.Grows,
      content: GrowWidget(
        growsData: this,
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appTertiaryColor
                  : appBaseWhiteTextColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
              ),
              boxShadow: (currentTheme.currentTheme() == ThemeMode.light)
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 10.0,
                        blurRadius: 25.0,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                GrowPageHeader(
                  isPlantSelected: _currentPlant != null,
                  currentGrow: _currentGrow,
                  currentPlantOp: _currentPlantOp,
                  isNotificationDisplayed: true,
                ),
                Divider(
                  color: appContentBackgroundColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
                GrowPageBody(
                  grows: _grows,
                  currentGrow: _currentGrow,
                  currentPlant: _currentPlant,
                  currentPlantOp: _currentPlantOp,
                  currentGrowOp: _currentGrowOp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setGrows(Future<List<Grow>> grows) {
    setState(() {
      _grows = grows;
      _currentPlant = null;
      _currentPlantOp = PlantOperation.Journal;
    });
  }

  void setCurrentGrow(Grow grow) {
    setState(() {
      _currentGrow = grow;
      _currentPlantOp = PlantOperation.Journal;

      if (_currentGrow != null &&
          _currentGrow.plants != null &&
          _currentGrow.plants.length == 1) {
        _currentPlant = _currentGrow.plants[0];
      } else {
        _currentPlant = null;
      }
    });
  }

  void setCurrentPlant(Plant plant) {
    setState(() {
      _currentPlant = plant;
      _currentPlantOp = PlantOperation.Journal;
    });
  }

  void setCurrentPlantOperation(PlantOperation operation) {
    setState(() {
      _currentPlantOp = operation;
    });
  }

  void startNewGrow() {
    setState(() {
      _grows = null;
      _currentGrow = null;
      _currentGrowOp = GrowOperation.AddGrow;
    });
  }

  void deleteCurrentGrow() {
    if (_currentGrow != null) {
      _deleteGrow();
    }
  }

  void _deleteGrow() async {
    bool safeToDelete = false;

    safeToDelete = await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: DankValidationDialog(
              titleText: 'Delete Grow',
              validationType: ValidationType.TextBasedValidation,
              messageText:
                  'Deleting a grow cannot be undone.  \n\nPlease be certain this is the action you want to take.',
              validationText: 'delete',
              cancelButtonText: 'Cancel',
              okButtonText: 'Delete',
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox(height: 20.0);
      },
    );

    // Save the change.  Hit the back-end API.
    if (safeToDelete) {
      deleteGrow(_currentGrow);

      setCurrentGrow(null);
    }
  }
}

class GrowWidget extends InheritedWidget {
  final GrowPageState growsData;

  GrowWidget({
    Key key,
    @required Widget child,
    @required this.growsData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(GrowWidget oldWidget) {
    return true;
  }
}
