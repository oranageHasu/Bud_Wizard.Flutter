import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared-widgets/screenHeader.dart';
import 'package:flutter/material.dart';

import 'plantCard.dart';

class PlantsPage extends StatefulWidget {

  @override
  _PlantsPageState createState() => _PlantsPageState();

}

class _PlantsPageState extends State<PlantsPage> {

  bool _error = false;
  Future<List<Plant>> _plants;

  @override
  void initState() {
    super.initState();
    _plants = getPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plants'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FadeIn(1.0, ScreenHeader(title: 'Plants')),
            FutureBuilder<List<Plant>> (
                future: _plants,
                builder: (context, snapshot) {

                  // If we're ready with data
                  if (snapshot.hasData) {
                    return Column(
                        children: <Widget>[
                          for (Plant plant in snapshot.data) FadeIn(3.0, PlantCard(plant: plant))
                        ]
                    );
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();

                }
            )
          ],
        ),
      ),

    );
  }
}