import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:bud_wizard/models/journal%20system/journalEntry.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantJournalEntry extends StatelessWidget {
  final JournalDay day;

  PlantJournalEntry({
    JournalDay day,
  }) : this.day = day;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: (day == null)
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: DankLabel(
                    displayText: 'No action this week...',
                    textStyle:
                        appLabelFontStyle.copyWith(fontSize: 25.0).copyWith(
                              color: appHintTextColor,
                            ),
                    textAlign: TextAlign.center,
                    padding: EdgeInsets.only(top: 35.0),
                  ),
                ),
              ],
            )
          : Card(
              color: appThirdColor,
              elevation: 5.0,
              clipBehavior: Clip.hardEdge,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DankLabel(
                      displayText: formatDateDisplay(day.entryDate),
                      textStyle: appLabelFontStyle,
                      padding: EdgeInsets.only(bottom: 5.0),
                    ),
                    for (JournalEntry entry in day.journalEntries)
                      DankLabel(
                        displayText: '-' + entry.entry,
                        textStyle: appLabelFontStyle.copyWith(fontSize: 15.0),
                        padding: EdgeInsets.only(left: 30.0),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
