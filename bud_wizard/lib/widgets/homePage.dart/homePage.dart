import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => displayContent(context));
  }

  @override
  Widget build(BuildContext context) {
    return DankNavigator(
      currentScreen: Screen.Home,
      content: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: appThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      simpleHome(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget simpleHome() {
    return FadeIn(
      2500,
      Container(
        height: 500.0,
        width: 500.0,
        child: Center(
          child: new Text(
            'Welcome to Bud Wizard',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 30,
              color: appBaseWhiteTextColor,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      _isVisible,
    );
  }

  void displayContent(BuildContext context) {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
