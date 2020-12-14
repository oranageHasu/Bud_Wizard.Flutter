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
      content: simpleHome(),
    );
  }

  Widget simpleHome() {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FadeIn(
              2000,
              Text(
                'Welcome to Bud Wizard',
                style: appHeaderFontStyle,
                textAlign: TextAlign.center,
              ),
              _isVisible,
            ),
          ),
        ],
      ),
    );
  }

  void displayContent(BuildContext context) {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
