import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api%20services/api-journal.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageSelector.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournalList.dart';
import 'package:bud_wizard/widgets/plant/journal/uploadImageDialog.dart';
import 'package:bud_wizard/widgets/plant/plantCard.dart';
import 'package:bud_wizard/widgets/plant/plantWeekSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

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
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 85.0,
              ),
              Expanded(
                child: Column(
                  children: [
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
                          formatDateDisplay(journal
                              .plantWeeks[_currentWeek - 1].startDate
                              .add(Duration(days: 6))),
                      textStyle: appInputHintFontStyle,
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50.0,
                margin: EdgeInsets.only(right: 35.0),
                child: InkWell(
                  onTap: uploadImage,
                  child: Tooltip(
                    message: 'Click to add an image to this week',
                    child: Icon(
                      Icons.add_a_photo,
                      size: 45.0,
                      color: appBaseWhiteTextColor,
                    ),
                  ),
                ),
              ),
            ],
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
            child: PlantJournalList(
              plant: currentPlant,
              plantDays: journal.plantWeeks[_currentWeek - 1].plantDays,
            ),
          ),
        ],
      ),
    );
  }

  void uploadImage() async {
    JournalWeek week;

    if (_journal != null) {
      _journal.then((data) {
        week = data.plantWeeks[_currentWeek - 1];
      }, onError: (e) {
        log(e);
      });

      bool opResult = await showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.85),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: UploadImageDialog(
                journalWeek: week,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox(height: 20.0);
        },
      );

      if (opResult) {
        // Tell the parent its data has changed and force a re-render
        print('To Do: Refresh current plant (after saving new Answer)');
      }
    }
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
