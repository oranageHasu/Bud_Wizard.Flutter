import 'package:bud_wizard/models/journal%20system/journal.dart';
import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api%20services/api-journal.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournalEntry.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';

class PlantJournal extends StatefulWidget {
  final Plant plant;

  PlantJournal({
    Plant plant,
  }) : this.plant = plant;

  @override
  _PlantJournalState createState() => _PlantJournalState(
        this.plant,
      );
}

class _PlantJournalState extends State<PlantJournal> {
  Plant plant;
  Future<Journal> _journal;

  _PlantJournalState(
    this.plant,
  );

  @override
  void initState() {
    super.initState();

    _journal = getJournal(plant.plantId);
  }

  @override
  void didUpdateWidget(PlantJournal oldWidget) {
    super.didUpdateWidget(oldWidget);

    plant = widget.plant;
    _journal = getJournal(plant.plantId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
      ),
      child: FutureBuilder<Journal>(
        future: _journal,
        builder: (context, snapshot) {
          Widget retval = DankLoading();

          if (snapshot.hasData) {
            List<JournalDay> plantDays = snapshot.data.plantWeeks[0].plantDays;

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (JournalDay day in plantDays)
                  PlantJournalEntry(
                    day: day,
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            return NoDataError();
          }

          return retval;
        },
      ),
    );
  }
}
