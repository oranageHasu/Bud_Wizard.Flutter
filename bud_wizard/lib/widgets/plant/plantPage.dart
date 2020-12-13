import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/slideIn.dart';
import 'package:flutter/material.dart';

class PlantPageArguments {
  final Plant plant;

  PlantPageArguments(this.plant);
}

class PlantPage extends StatefulWidget {
  final Plant plant;

  PlantPage({Plant plant}) : this.plant = plant;

  @override
  _PlantPageState createState() => _PlantPageState(this.plant);
}

class _PlantPageState extends State<PlantPage> {
  Plant plant;

  _PlantPageState(this.plant);

  @override
  void initState() {
    super.initState();
    //_plant = getPlants();
  }

  @override
  Widget build(BuildContext context) {
    // Gather the provided arguments
    final PlantPageArguments args = ModalRoute.of(context).settings.arguments;

    if (args != null) {
      plant = args.plant;
    }

    return Scaffold(
      //appBar: DankAppBar(title: plant.name),
      body: Center(
        child: Column(
          children: <Widget>[
            SlideIn(1.0, Text('Im a Plant')),
          ],
        ),
      ),
    );
  }

  String getName() {
    String retval = "{No Plant Name}";

    if (plant != null) {
      retval = plant.name;
    }

    return retval;
  }
}
