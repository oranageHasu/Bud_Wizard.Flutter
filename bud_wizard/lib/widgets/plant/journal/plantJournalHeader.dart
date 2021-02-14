import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/plant/journal/uploadImageDialog.dart';
import 'package:bud_wizard/widgets/plant/plantWeekSelector.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicTooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';

class PlantJournalHeader extends StatelessWidget {
  final Journal journal;
  final int currentWeekIndex;
  final Guid plantId;

  PlantJournalHeader({
    @required Journal journal,
    @required int currentWeekIndex,
    @required Guid plantId,
  })  : this.journal = journal,
        this.currentWeekIndex = currentWeekIndex,
        this.plantId = plantId;

  @override
  Widget build(BuildContext context) {
    JournalWeek currentWeek = journal.plantWeeks[currentWeekIndex];

    return Container(
      height: 100.0,
      child: Container(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        decoration: BoxDecoration(
          color: (currentTheme.isDarkTheme())
              ? Color.fromRGBO(46, 48, 54, 1)
              : appLightSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 150.0,
              child: Column(
                children: [
                  DankLabel(
                    displayText: 'Weekly Journal',
                    textStyle: appHeaderFontStyle.copyWith(
                      fontSize: 20.0,
                      color: appBaseColor,
                    ),
                    padding: EdgeInsets.only(top: 10.0),
                    textAlign: TextAlign.center,
                  ),
                  DankLabel(
                    displayText: formatDateDisplay(currentWeek.startDate) +
                        ' - ' +
                        formatDateDisplay(
                            currentWeek.startDate.add(Duration(days: 6))),
                    textStyle: appInputHintFontStyle.copyWith(
                      fontSize: 11.0,
                      color: (currentTheme.isDarkTheme())
                          ? appBaseWhiteTextColor
                          : appBaseBlackTextColor,
                    ),
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                ],
              ),
            ),
            Container(
              color: (currentTheme.isDarkTheme())
                  ? appBaseWhiteTextColor.withOpacity(0.3)
                  : appErrorColor,
              width: 1.5,
              margin: EdgeInsets.only(right: 5.0),
            ),
            Expanded(
              child: PlantWeekSelector(
                journal: journal,
                currentIndex: currentWeekIndex,
              ),
            ),
            Container(
              width: 50.0,
              margin: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: addJournalEntry,
                child: DankBasicTooltip(
                  tooltipText: 'Click to add a new journey entry',
                  child: Icon(
                    Icons.edit,
                    size: 45.0,
                    color: (currentTheme.isDarkTheme())
                        ? appBaseWhiteTextColor.withOpacity(0.7)
                        : appBaseBlackTextColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            Container(
              width: 50.0,
              margin: EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: uploadImage,
                child: DankBasicTooltip(
                  tooltipText: 'Click to add an image to this week',
                  child: Icon(
                    Icons.add_a_photo,
                    size: 45.0,
                    color: (currentTheme.isDarkTheme())
                        ? appBaseWhiteTextColor.withOpacity(0.7)
                        : appBaseBlackTextColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addJournalEntry() {
    log('To Do: Add Journal Entry');
  }

  void uploadImage() async {
    bool opResult = await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.85),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: UploadImageDialog(
              plantId: plantId,
              journalWeek: journal.plantWeeks[currentWeekIndex],
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
      log('To Do: Refresh current plant (after saving new Answer)');
    }
  }
}
