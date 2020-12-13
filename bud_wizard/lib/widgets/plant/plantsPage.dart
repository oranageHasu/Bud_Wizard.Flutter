import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/slideIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/screenHeader.dart';
import 'package:flutter/material.dart';

import 'plantCard.dart';

class PlantsPage extends StatefulWidget {
  @override
  _PlantsPageState createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  Future<List<Plant>> _plants;

  @override
  void initState() {
    super.initState();
    _plants = getPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: DankAppBar(title: 'Plants'),
      body: Center(
        child: Column(
          children: <Widget>[
            SlideIn(1.0, ScreenHeader(title: 'Plants')),
            FutureBuilder<List<Plant>>(
              future: _plants,
              builder: (context, snapshot) {
                // If we're ready with data
                if (snapshot.hasData) {
                  return Column(children: <Widget>[
                    for (Plant plant in snapshot.data)
                      SlideIn(3.0, PlantCard(plant: plant))
                  ]);
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
      //drawer: Navigation(),
    );
  }
}
