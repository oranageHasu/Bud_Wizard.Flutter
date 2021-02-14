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
  _PlantJournalListState createState() => _PlantJournalListState();
}

class _PlantJournalListState extends State<PlantJournalList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 5.0,
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          if (widget.plantDays.isEmpty)
            PlantJournalEntry(day: null)
          else
            for (int i = 0; i < widget.plantDays.length; i++)
              PlantJournalEntry(
                day: widget.plantDays[i],
                isFirst: i == 0,
                isLast: i == widget.plantDays.length - 1,
              ),
        ],
      ),
    );
  }
}
