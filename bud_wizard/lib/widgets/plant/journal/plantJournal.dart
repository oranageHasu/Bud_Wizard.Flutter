import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/journal/plantJournalEntry.dart';
import 'package:flutter/material.dart';

class PlantJournal extends StatelessWidget {
  final Plant plant;

  PlantJournal({
    Plant plant,
  }) : this.plant = plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 15.0,
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          PlantJournalEntry(),
          PlantJournalEntry(),
          PlantJournalEntry(),
          PlantJournalEntry(),
          PlantJournalEntry(),
        ],
      ),
    );
  }
}
