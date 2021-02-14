import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:bud_wizard/models/journal%20system/journalEntry.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantJournalEntry extends StatefulWidget {
  final JournalDay day;
  final bool isFirst;
  final bool isLast;

  PlantJournalEntry({
    @required JournalDay day,
    bool isFirst = false,
    bool isLast = false,
  })  : this.day = day,
        this.isFirst = isFirst,
        this.isLast = isLast;

  @override
  _PlantJournalEntryState createState() => _PlantJournalEntryState();
}

class _PlantJournalEntryState extends State<PlantJournalEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: (widget.day == null)
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.day.journalEntries.length; i++)
                  _journalEntry(
                    widget.day.journalEntries[i],
                    i == 0,
                    i == widget.day.journalEntries.length - 1,
                  ),
              ],
            ),
    );
  }

  Widget _journalEntry(
    JournalEntry entry,
    bool isFirst,
    bool isLast,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.only(
          topLeft:
              (widget.isFirst && isFirst) ? Radius.circular(5) : Radius.zero,
          bottomLeft:
              (widget.isLast && isLast) ? Radius.circular(5) : Radius.zero,
        ),
      ),
      child: Container(
        height: 30.0,
        margin: EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          color: appBaseWhiteTextColor,
          borderRadius: BorderRadius.only(
            topLeft:
                (widget.isFirst && isFirst) ? Radius.circular(5) : Radius.zero,
            bottomLeft:
                (widget.isLast && isLast) ? Radius.circular(5) : Radius.zero,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: (!isLast) ? 29.0 : 30.0,
              child: Row(
                children: [
                  (isFirst)
                      ? Center(
                          child: DankLabel(
                            width: 150.0,
                            displayText:
                                formatDateDisplay(widget.day.entryDate),
                            textStyle: appLabelFontStyle.copyWith(
                              color: appBaseBlackTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(
                          width: 150.0,
                        ),
                  Container(
                    color: appErrorColor,
                    width: 1.5,
                  ),
                  DankLabel(
                    displayText: '-' + entry.entry,
                    textStyle: appJournalEntryFontStyle.copyWith(
                      color: appBaseBlackTextColor,
                    ),
                    padding: EdgeInsets.only(left: 30.0),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Divider(
                color: Colors.blue,
                height: 1.0,
                thickness: 1.0,
              ),
          ],
        ),
      ),
    );
  }
}
