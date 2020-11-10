import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/grow/screenHeader.dart';
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
        title: Text('Bud Wizard'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              FadeIn(1.0, ScreenHeader()),
              FutureBuilder<List<Plant>> (
                  future: _plants,
                  builder: (context, snapshot) {

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
          color: Colors.grey[100],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Oranagehasu"),
              accountEmail: Text("Oranagehasu@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("Image"),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("plant"),
                )
              ],
            ),
            ListTile(
              title: new Text("Messages"),
              leading: new Icon(Icons.mail),
            ),
            Divider(
              height: 0.1,
            ),
            ListTile(
              title: new Text("Grows"),
              leading: new Icon(Icons.inbox),
            ),
            ListTile(
              title: new Text("Social"),
              leading: new Icon(Icons.people),
            ),
            ListTile(
              title: new Text("Knowledge Base"),
              leading: new Icon(Icons.info),
            ),
            ListTile(
              title: new Text("Settings"),
              leading: new Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}