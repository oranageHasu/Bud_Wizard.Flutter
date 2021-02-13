import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
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
  String _defaultPlantName = 'Plant 1';

  @override
  void initState() {
    super.initState();

    _newPlant = Plant(
      plantId: null,
      growId: widget.grow.growId,
      startDate: DateTime.now(),
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
            autofocus: true,
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
                  displayText: _defaultPlantName,
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
          SizedBox(height: 15.0),
          DankLabel(
            displayText: 'Is your strain...',
            textStyle: appLabelFontStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
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
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DankButton(
                  buttonType: DankButtonType.Outline,
                  buttonText: 'Cancel',
                  textColor: (currentTheme.isDarkTheme())
                      ? appBaseWhiteTextColor
                      : appBaseBlackTextColor,
                  textStyle: appLabelFontStyle,
                  borderRadius: 5.0,
                  onPressed: _cancelNewPlant,
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(right: 15.0),
                ),
                DankButton(
                  buttonType: DankButtonType.Flat,
                  buttonText: 'Finished',
                  textStyle: appLabelFontStyle,
                  borderRadius: 5.0,
                  onPressed: _persistPlant,
                  padding: EdgeInsets.all(15.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _plantGeneticsChanged(int value) {
    setState(() {
      _newPlant.genetics =
          GeneticType.values.firstWhere((e) => e.index == value);
    });
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
    setState(() {
      _newPlant.strain = value;
    });
  }

  void _persistPlant() {
    if (_newPlant.startDate == null) {
      print('start date is null');
    }

    if (_newPlant.name == null) {
      _newPlant.name = _defaultPlantName;
    }

    print('Name: ' + ((_newPlant.name != null) ? _newPlant.name : 'NULL'));
    print(
        'strain: ' + ((_newPlant.strain != null) ? _newPlant.strain : 'NULL'));
    print('Start Date: ' + formatDate(_newPlant.startDate));
    print(
      'genetics: ' +
          formatEnum(
            _newPlant.genetics.toString(),
          ),
    );
    print(
      'sex: ' + _newPlant.sex.toString(),
    );
    print(
      'growthState: ' + _newPlant.growthState.toString(),
    );

    GrowPage.of(context).savePlant(_newPlant).then(
      (bool opResult) {
        if (opResult) {
          GrowPage.of(context).finishedNewPlant();
        }
      },
    );
  }

  void _cancelNewPlant() {
    GrowPage.of(context).finishedNewPlant();
  }
}
