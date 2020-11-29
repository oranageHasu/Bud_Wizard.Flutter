import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/navigation%20system/appBar.dart';
import 'package:bud_wizard/widgets/navigation%20system/navigation.dart';
import 'package:bud_wizard/widgets/shared-widgets/animations/fadeIn.dart';
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
    return Scaffold(
      appBar: DankAppBar(title: 'Bud Wizard'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FadeIn(
              2500,
              Container(
                height: 500.0,
                width: 500.0,
                child: new Text(
                  'Welcome to Bud Wizard',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 30,
                    color: appBaseWhiteTextColor.shade700,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              _isVisible,
            ),
          ],
        ),
      ),
      drawer: Navigation(),
      backgroundColor: appBaseBackgroundColor,
    );
  }

  void displayContent(BuildContext context) {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
