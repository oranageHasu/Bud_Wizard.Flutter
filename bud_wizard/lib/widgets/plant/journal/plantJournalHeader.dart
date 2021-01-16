import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/journal%20system/journalWeek.dart';
import 'package:bud_wizard/services/logger-service.dart';
import 'package:bud_wizard/widgets/plant/journal/uploadImageDialog.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip-basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';

class PlantJournalHeader extends StatelessWidget {
  final JournalWeek week;
  final Guid plantId;

  PlantJournalHeader({
    @required JournalWeek week,
    @required Guid plantId,
  })  : this.week = week,
        this.plantId = plantId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DankLabel(
                displayText: 'Weekly Journal',
                textStyle: appHeaderFontStyle.copyWith(fontSize: 20.0),
                padding: EdgeInsets.only(top: 10.0),
              ),
              DankLabel(
                displayText: formatDateDisplay(week.startDate) +
                    ' - ' +
                    formatDateDisplay(week.startDate.add(Duration(days: 6))),
                textStyle: appInputHintFontStyle,
                padding: EdgeInsets.only(top: 5.0),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox.shrink(),
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
                color: appBaseWhiteTextColor,
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
                color: appBaseWhiteTextColor,
              ),
            ),
          ),
        ),
      ],
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
      log('To Do: Refresh current plant (after saving new Answer)');
    }
  }
}
