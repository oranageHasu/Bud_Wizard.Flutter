import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/animations/fadeIn.dart';
import 'package:flutter/material.dart';

class PlantPageArguments {
  final Plant plant;

  PlantPageArguments(this.plant);
}

class PlantPage extends StatefulWidget {

  final Plant plant;

  PlantPage({
    Plant plant
  }): this.plant = plant;

  @override
  _PlantPageState createState() => _PlantPageState(this.plant);

}

class _PlantPageState extends State<PlantPage> {

  bool _error = false;
  Plant plant;

  _PlantPageState(this.plant);

  @override
  void initState() {
    super.initState();
    //_plant = getPlants();
  }

  @override
  Widget build(BuildContext context) {

    final PlantPageArguments args = ModalRoute.of(context).settings.arguments;

    if (args != null) {
      plant = args.plant;
      print('Strain: ' + args.plant.strain);
    } else {
      print('Plant is null.');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(getName()),
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

  String getName() {

    String retval;

    if (plant != null) {
      retval = plant.name;
    } else {
      retval = "{No Plant Name}";
    }

    return retval;

  }
}