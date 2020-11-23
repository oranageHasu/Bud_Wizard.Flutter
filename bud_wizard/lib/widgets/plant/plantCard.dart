import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/plantPage.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatefulWidget {

  final Plant plant;

  PlantCard({
    Plant plant
  }): this.plant = plant;

  @override
  _PlantCardState createState() => _PlantCardState(this.plant);

}

class _PlantCardState extends State<PlantCard> {

  _PlantCardState(this.plant);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: () => {
            Navigator.pushNamed(
                context,
                '/Plant',
                arguments: new PlantPageArguments(plant)
            ),
          }, // handle your onTap here
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage('https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2016/04/05/marijuana.jpg'),
                ),
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
              ),
              Column(
                children: [
                  Text(this.plant.name),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    height: 10,
                    width: 400
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                    ),
                    margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                    height: 10,
                    width: 380
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                      ),
                      margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      height: 10,
                      width: 380
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                      ),
                      margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      height: 10,
                      width: 380
                  ),
                ],
              )
            ],
          ),
        )
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          const Radius.circular(5),
        ),
      ),
      height: 100,
      width: 500,
      margin: const EdgeInsets.only(top: 7.0, bottom: 7.0),
      clipBehavior: Clip.hardEdge,
    );
  }
}