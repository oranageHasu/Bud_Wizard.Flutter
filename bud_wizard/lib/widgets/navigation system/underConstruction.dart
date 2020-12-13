import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UnderConstruction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 25.0),
                child: Icon(Icons.construction, color: Colors.orange[200]),
              ),
              Text(
                'Under Construction',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 30,
                  color: appBaseWhiteTextColor,
                  fontFamily: 'Montserrat',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Icon(Icons.construction, color: Colors.orange[200]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
