import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/animations/fadeIn.dart';
import 'package:flutter/material.dart';

import 'plantCard.dart';

class PlantPage extends StatefulWidget {

  @override
  _PlantPageState createState() => _PlantPageState();

}

class _PlantPageState extends State<PlantPage> {

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
        title: Text('Bud Wizard'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FadeIn(1.0, Text('Im a Plant')),
          ],
        ),
      ),

    );
  }
}