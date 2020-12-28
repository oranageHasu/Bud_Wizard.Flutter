import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/services/api%20services/api-journal.dart';
import 'package:bud_wizard/services/api%20services/api-question.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageSelector.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournal.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/plant/plantWeekSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-expanded-section.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantDetail extends StatefulWidget {
  final Plant currentPlant;
  final PlantOperation currentOperation;

  PlantDetail({
    Plant plant,
    PlantOperation operation,
  })  : this.currentPlant = plant,
        this.currentOperation = operation;

  static PlantDetailState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlantDetailWidget>()
        .plantsData;
  }

  @override
  State<StatefulWidget> createState() => PlantDetailState(
        this.currentPlant,
        this.currentOperation,
      );
}

class PlantDetailState extends State<PlantDetail> {
  Plant currentPlant;
  PlantOperation currentOperation;
  Future<Journal> _journal;
  Future<List<Question>> _questions;
  int _currentWeek = 1;

  PlantDetailState(
    this.currentPlant,
    this.currentOperation,
  );

  void setCurrentWeek(int selectedWeek) {
    setState(() {
      _currentWeek = selectedWeek;
    });
  }

  @override
  void initState() {
    super.initState();

    _journal = getJournal(currentPlant.plantId);
    _questions = getQuestions(currentPlant.plantId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantDetail oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPlant != widget.currentPlant) {
      currentPlant = widget.currentPlant;
    }

    currentOperation = widget.currentOperation;
  }

  @override
  Widget build(BuildContext context) {
    return PlantDetailWidget(
      plantsData: this,
      child: Container(
        color: appSecondColor,
        child: (currentOperation == PlantOperation.Journal)
            ? FutureBuilder<Journal>(
                future: _journal,
                builder: (context, snapshot) {
                  Widget retval = DankLoading();

                  if (snapshot.hasData) {
                    return plantJournal(snapshot.data);
                  } else if (snapshot.hasError) {
                    return NoDataError();
                  }

                  return retval;
                },
              )
            : other(),
      ),
    );
  }

  Widget plantJournal(Journal journal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        PlantCard(
          plant: currentPlant,
          isFeatured: true,
          isSelectable: false,
        ),
        PlantWeekSelector(
          journal: journal,
          currentIndex: _currentWeek,
        ),
        DankLabel(
          displayText: 'Weekly Journal',
          textStyle: appHeaderFontStyle.copyWith(fontSize: 20.0),
          textAlign: TextAlign.center,
          padding: EdgeInsets.only(top: 10.0),
        ),
        DankLabel(
          displayText: formatDateDisplay(
                  journal.plantWeeks[_currentWeek - 1].startDate) +
              ' - ' +
              formatDateDisplay(journal.plantWeeks[_currentWeek - 1].startDate
                  .add(Duration(days: 6))),
          textStyle: appInputHintFontStyle,
          textAlign: TextAlign.center,
          padding: EdgeInsets.only(top: 5.0),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Divider(
            color: appThirdColor,
            height: 2.0,
            thickness: 2.0,
            indent: 25.0,
            endIndent: 25.0,
          ),
        ),
        PlantImageSelector(plant: currentPlant),
        Expanded(
          child: PlantJournal(
            plant: currentPlant,
            plantDays: journal.plantWeeks[_currentWeek - 1].plantDays,
          ),
        ),
      ],
    );
  }

  Widget other() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        FutureBuilder<List<Question>>(
          future: _questions,
          builder: (context, snapshot) {
            Widget retval = DankLoading();

            if (snapshot.hasData) {
              return questionList(snapshot.data);
            } else if (snapshot.hasError) {
              return NoDataError();
            }

            return retval;
          },
        )
      ],
    );
  }

  Widget questionList(List<Question> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        DankExpandedSection(
          expand: true,
          child: DankLabel(
            displayText: 'Test',
            textStyle: appLabelFontStyle,
          ),
        ),
      ],
    );
  }
}

class PlantDetailWidget extends InheritedWidget {
  final PlantDetailState plantsData;

  PlantDetailWidget({
    Key key,
    @required Widget child,
    @required this.plantsData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(PlantDetailWidget oldWidget) {
    return true;
  }
}
