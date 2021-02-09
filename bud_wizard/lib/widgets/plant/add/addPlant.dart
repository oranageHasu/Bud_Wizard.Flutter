import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-date-picker.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddPlant extends StatefulWidget {
  final Grow grow;

  AddPlant({
    @required Grow grow,
  }) : this.grow = grow;

  @override
  State<StatefulWidget> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  Plant _newPlant;
  bool _plantNameHasFocus = false;
  bool _displayDefaultPlantName = true;

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
    return Container(
      color: appDarkSecondaryColor,
      padding: EdgeInsets.only(top: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          FadeIn(
            duration: 1000,
            isVisible: true,
            child: DankLabel(
              displayText:
                  'Start by providing some basic information about your plant...',
              textStyle: appInstructionHeaderFontStyle,
              padding: EdgeInsets.only(bottom: 35.0),
            ),
          ),
          FadeIn(
            duration: 1000,
            delay: Duration(seconds: 1),
            isVisible: true,
            child: _addPlantBody(),
          ),
        ],
      ),
    );
  }

  Widget _addPlantBody() {
    return Container(
      constraints: BoxConstraints(maxWidth: 500.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DankTextField(
            labelText:
                (!_plantNameHasFocus) ? 'Enter a plant name' : 'Plant Name',
            hintText: 'Type the name of your plant',
            margin: EdgeInsets.zero,
            onChanged: plantNameChanged,
            onFocus: () {
              setState(() {
                _plantNameHasFocus = true;
              });
            },
            onLostFocus: (String value) {
              setState(() {
                _plantNameHasFocus = false;
              });
            },
          ),
          SizedBox(height: 3.0),
          FadeIn(
            duration: 1000,
            delay: Duration(milliseconds: 2500),
            isVisible: _displayDefaultPlantName,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DankLabel(
                  displayText: '...or we can just call it',
                  textStyle: appInputHintFontStyle,
                ),
                DankLabel(
                  displayText: 'Plant 1',
                  textStyle: appInputHintFontStyle.copyWith(
                    color: appBaseColor,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              DankDatePicker(
                label: 'Start Date: ',
                defaultDate: widget.grow.startDate,
                onDateChanged: (DateTime date) {
                  print('To Do: Plant Start Date Changed.');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void plantNameChanged(String value) {
    bool displayDefaultPlantName = true;

    if (value.length > 0) {
      displayDefaultPlantName = false;
    }

    if (_displayDefaultPlantName != displayDefaultPlantName) {
      setState(() {
        _displayDefaultPlantName = displayDefaultPlantName;
      });
    }

    print('Plant Name Changed To: ' + value);
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
