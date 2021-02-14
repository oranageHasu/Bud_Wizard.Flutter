import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:bud_wizard/models/journal%20system/journalEntry.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantJournalEntry extends StatefulWidget {
  final JournalDay day;
  final bool isLast;

  PlantJournalEntry({
    @required JournalDay day,
    bool isLast = false,
  })  : this.day = day,
        this.isLast = isLast;

  @override
  _PlantJournalEntryState createState() => _PlantJournalEntryState();
}

class _PlantJournalEntryState extends State<PlantJournalEntry> {
  final lineHeight = 35.0;

  @override
  Widget build(BuildContext context) {
    return (widget.day == null)
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
                  false,
                ),
              for (int i = 0; i < 11; i++)
                _journalEntry(
                  null,
                  false,
                  false,
                ),
              _journalEntry(
                null,
                false,
                true,
              ),
            ],
          );
  }

  Widget _journalEntry(
    JournalEntry entry,
    bool isFirst,
    bool isLast,
  ) {
    return Container(
      height: lineHeight,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
        color: (currentTheme.isDarkTheme())
            ? Color.fromRGBO(46, 48, 54, 1)
            : appLightSecondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft:
              (widget.isLast && isLast) ? Radius.circular(5) : Radius.zero,
          bottomRight:
              (widget.isLast && isLast) ? Radius.circular(5) : Radius.zero,
        ),
      ),
      child: Column(
        children: [
          if (isFirst)
            Container(
              color: (currentTheme.isDarkTheme())
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.blue,
              height: 1.0,
            ),
          Container(
            height: _determineLineHeight(
              isFirst,
              isLast,
            ),
            child: Row(
              children: [
                (isFirst)
                    ? Center(
                        child: DankLabel(
                          width: 150.0,
                          displayText: formatDateDisplay(widget.day.entryDate),
                          textStyle: appLabelFontStyle.copyWith(
                            color: (currentTheme.isDarkTheme())
                                ? appBaseWhiteTextColor
                                : appBaseBlackTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(
                        width: 150.0,
                      ),
                Container(
                  color: (currentTheme.isDarkTheme())
                      ? appErrorColor.withOpacity(0.5)
                      : appErrorColor,
                  width: 1.5,
                ),
                if (entry != null)
                  DankLabel(
                    displayText: '-' + entry.entry,
                    textStyle: appJournalEntryFontStyle.copyWith(
                      color: (currentTheme.isDarkTheme())
                          ? appBaseWhiteTextColor
                          : appBaseBlackTextColor,
                    ),
                    padding: EdgeInsets.only(left: 30.0),
                  ),
              ],
            ),
          ),
          if (!isLast)
            Container(
              color: (currentTheme.isDarkTheme())
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.blue,
              height: 1.0,
            ),
        ],
      ),
    );
  }

  double _determineLineHeight(bool isFirst, bool isLast) {
    double retval = lineHeight - 1;

    if (isFirst) {
      retval = lineHeight - 2;
    } else if (isLast) {
      retval = lineHeight;
    }

    return retval;
  }
}
