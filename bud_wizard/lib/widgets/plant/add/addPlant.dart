import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddPlant extends StatefulWidget {
  static _AddPlantState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AddPlantWidget>()
        .plantData;
  }

  @override
  State<StatefulWidget> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  Plant _newPlant;

  @override
  void initState() {
    super.initState();

    sessionInfo.then((data) {
      setState(() {
        _newPlant = Plant(
          plantId: null,
          growId: null,
        );
      });
    }, onError: (e) {
      log(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddPlantWidget(
      plantData: this,
      child: Container(
        color: appDarkSecondaryColor,
        child: FadeIn(
          duration: 1000,
          isVisible: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              DankLabel(
                displayText: 'Farts Mcfinly',
              )
            ],
          ),
        ),
      ),
    );
  }

/*
  void updateGrowName(String name) {
    _newGrow.name = name;
  }

  void updateGrowDate(DateTime date) {
    _newGrow.startDate = date;
  }

  void setGrowSetting(GrowSetting setting) {
    setState(() {
      _newGrow.setting = setting;
    });
  }

  void setGrowLighting(List<GrowLight> lights) {
    setState(() {
      _newGrow.growLights = lights;
    });
  }

  void updatePrivacy(GrowPrivacy privacySettings) {
    _newGrow.privacySettings = privacySettings;
  }
*/
  void persistPlant() {
    /*
    if (_newPlant.startDate == null) {
      _newPlant.startDate = DateTime.now();
    }

    print('Name: ' + _newPlant.name);
    print('Location: ' + formatEnum(_newGrow.setting.toString()));
    print('Start Date: ' + formatDate(_newGrow.startDate));

    print('\n\nPrivacy:');
    print('Blanket Setting: ' +
        formatEnum(_newGrow.privacySettings.privacySetting.toString()));
    print('Sharing Images: ' + _newGrow.privacySettings.sharePhotos.toString());
    print(
        'Sharing Journal: ' + _newGrow.privacySettings.shareJournal.toString());
    print('Allowing Comments: ' +
        _newGrow.privacySettings.allowComments.toString());
    print('Allows ML: ' + _newGrow.privacySettings.allowML.toString());
    print('Allows Notifications: ' +
        _newGrow.privacySettings.allowNotifications.toString());

    GrowPage.of(context).saveGrow(_newGrow).then(
      (bool opResult) {
        if (opResult) {
          GrowPage.of(context).finishedNewGrow();
        }
      },
    );
    */
  }

  void cancelNewPlant() {
    //GrowPage.of(context).finishedNewPlant();
  }

  void learnMoreAboutPlants() {
    print('To Do: Knowledge Base: Plants');
  }
}

class AddPlantWidget extends InheritedWidget {
  final _AddPlantState plantData;

  AddPlantWidget({
    Key key,
    @required Widget child,
    @required this.plantData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AddPlantWidget oldWidget) {
    return true;
  }
}
