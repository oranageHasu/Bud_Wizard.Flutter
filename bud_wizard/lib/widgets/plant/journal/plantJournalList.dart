import 'package:bud_wizard/models/journal%20system/journalDay.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournalEntry.dart';
import 'package:flutter/material.dart';

class PlantJournalList extends StatefulWidget {
  final Plant plant;
  final List<JournalDay> plantDays;

  PlantJournalList({
    @required Plant plant,
    @required List<JournalDay> plantDays,
  })  : this.plant = plant,
        this.plantDays = plantDays;

  @override
  _PlantJournalListState createState() => _PlantJournalListState(
        this.plant,
        this.plantDays,
      );
}

class _PlantJournalListState extends State<PlantJournalList> {
  Plant plant;
  List<JournalDay> plantDays;

  _PlantJournalListState(
    this.plant,
    this.plantDays,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(PlantJournalList oldWidget) {
    super.didUpdateWidget(oldWidget);

    plant = widget.plant;
    plantDays = widget.plantDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          if (plantDays.isEmpty)
            PlantJournalEntry(day: null)
          else
            for (JournalDay day in plantDays)
              PlantJournalEntry(
                day: day,
              ),
        ],
      ),
    );
  }
}
