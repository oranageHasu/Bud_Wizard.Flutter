import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api%20services/api-journal.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageSelector.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournalHeader.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournalList.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlantJournal extends StatefulWidget {
  final Plant currentPlant;

  PlantJournal({
    Plant currentPlant,
  }) : this.currentPlant = currentPlant;

  static PlantJournalState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlantJournalWidget>()
        .journalData;
  }

  @override
  State<StatefulWidget> createState() => PlantJournalState(
        this.currentPlant,
      );
}

class PlantJournalState extends State<PlantJournal> {
  Plant currentPlant;
  Future<Journal> _journal;
  int _currentWeek = 1;

  PlantJournalState(
    this.currentPlant,
  );

  void setCurrentWeek(int week) {
    setState(() {
      _currentWeek = week;
    });
  }

  @override
  void initState() {
    super.initState();

    _journal = getJournal(currentPlant.plantId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantJournal oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPlant != widget.currentPlant) {
      currentPlant = widget.currentPlant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Journal>(
      future: _journal,
      builder: (context, snapshot) {
        Widget retval = DankLoading();

        if (snapshot.hasData) {
          return content(snapshot.data);
        } else if (snapshot.hasError) {
          return NoDataError();
        }

        return retval;
      },
    );
  }

  Widget content(Journal journal) {
    return PlantJournalWidget(
      journalData: this,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          PlantCard(
            plant: currentPlant,
          ),
          PlantJournalHeader(
            journal: journal,
            currentWeekIndex: _currentWeek - 1,
            plantId: currentPlant.plantId,
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Divider(
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appDarkTertiaryColor
                  : appLightTertiaryColor,
              height: 2.0,
              thickness: 2.0,
            ),
          ),
          PlantImageSelector(plant: currentPlant),
          Expanded(
            child: PlantJournalList(
              plant: currentPlant,
              plantDays: journal.plantWeeks[_currentWeek - 1].plantDays,
            ),
          ),
        ],
      ),
    );
  }
}

class PlantJournalWidget extends InheritedWidget {
  final PlantJournalState journalData;

  PlantJournalWidget({
    Key key,
    @required Widget child,
    @required this.journalData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(PlantJournalWidget oldWidget) {
    return true;
  }
}
