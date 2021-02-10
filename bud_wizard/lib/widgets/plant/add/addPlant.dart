import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-date-picker.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-radio-button.dart';
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
  bool _plantStrainHasFocus = false;
  bool _displayDefaultPlantName = true;

  @override
  void initState() {
    super.initState();

    _newPlant = Plant(
      plantId: null,
      growId: widget.grow.growId,
    );
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
            onChanged: _plantNameChanged,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DankDatePicker(
                label: 'Start Date: ',
                defaultDate: widget.grow.startDate,
                onDateChanged: (DateTime date) {
                  print('To Do: Plant Start Date Changed.');
                },
              ),
              Expanded(
                child: DankTextField(
                  labelText:
                      (!_plantStrainHasFocus) ? 'Enter the strain' : 'Strain',
                  hintText: 'Type the strain you are growing',
                  margin: EdgeInsets.only(left: 20.0),
                  onChanged: _plantStrainChanged,
                  onFocus: () {
                    setState(() {
                      _plantStrainHasFocus = true;
                    });
                  },
                  onLostFocus: (String value) {
                    setState(() {
                      _plantStrainHasFocus = false;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 40.0),
          DankLabel(
            displayText: 'Is your strain...',
            textStyle: appLabelFontStyle,
          ),
          Container(
            height: 35.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 15.0,
                ),
                DankRadioButton(
                  id: GeneticType.Hybrid.index,
                  currentIndex: _newPlant.genetics.index,
                  displayText: 'Hybrid',
                  onTapped: _plantGeneticsChanged,
                ),
                Container(
                  width: 15.0,
                ),
                DankRadioButton(
                  id: GeneticType.Indica.index,
                  currentIndex: _newPlant.genetics.index,
                  displayText: 'Indica',
                  onTapped: _plantGeneticsChanged,
                ),
                Container(
                  width: 15.0,
                ),
                DankRadioButton(
                  id: GeneticType.Sativa.index,
                  currentIndex: _newPlant.genetics.index,
                  displayText: 'Sativa',
                  onTapped: _plantGeneticsChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _plantGeneticsChanged(int value) {
    print('To Do: Genetics changed.');
  }

  void _plantNameChanged(String value) {
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

  void _plantStrainChanged(String value) {
    print('Plant Strain Changed To: ' + value);
  }

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
    GrowPage.of(context).finishedNewPlant();
  }

  void learnMoreAboutPlants() {
    print('To Do: Knowledge Base: Plants');
  }
}
