import 'package:bud_wizard/classes/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UnknownRoute extends StatelessWidget {
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
                child:
                    Icon(Icons.error_outline_rounded, color: Colors.red[200]),
              ),
              Text(
                'Oops!  Something went wrong...  Please contact a Developer.',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 30,
                  color: appBaseWhiteTextColor,
                  fontFamily: 'Montserrat',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child:
                    Icon(Icons.error_outline_rounded, color: Colors.red[200]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
