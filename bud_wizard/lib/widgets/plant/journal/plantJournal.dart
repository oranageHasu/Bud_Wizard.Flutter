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
  State<StatefulWidget> createState() => PlantJournalState();
}

class PlantJournalState extends State<PlantJournal> {
  Future<Journal> _journal;
  int _currentWeek = 1;

  void setCurrentWeek(int week) {
    setState(() {
      _currentWeek = week;
    });
  }

  @override
  void initState() {
    super.initState();

    _journal = getJournal(widget.currentPlant.plantId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantJournal oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPlant != widget.currentPlant) {
      _journal = getJournal(widget.currentPlant.plantId);
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
        children: [
          PlantCard(
            plant: widget.currentPlant,
          ),
          PlantImageSelector(plant: widget.currentPlant),
          Container(
            height: 600.0,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: (currentTheme.isDarkTheme())
                      ? appBaseWhiteTextColor.withOpacity(0.05)
                      : appBaseBlackTextColor.withOpacity(0.1),
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              children: [
                PlantJournalHeader(
                  journal: journal,
                  currentWeekIndex: _currentWeek - 1,
                  plantId: widget.currentPlant.plantId,
                ),
                Expanded(
                  child: PlantJournalList(
                    plant: widget.currentPlant,
                    plantDays: journal.plantWeeks[_currentWeek - 1].plantDays,
                  ),
                ),
              ],
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
