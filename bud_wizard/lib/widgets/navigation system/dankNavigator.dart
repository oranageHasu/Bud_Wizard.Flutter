import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankAppBar.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankOperationPanel.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:flutter/material.dart';

class DankNavigator extends StatelessWidget {
  final Widget content;
  final Screen currentScreen;

  DankNavigator({
    @required Widget content,
    @required Screen currentScreen,
  })  : this.content = content,
        this.currentScreen = currentScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBaseBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          DankAppBar(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                DankOperationPanel(currentScreen: currentScreen),
                content
              ],
            ),
          ),
        ],
      ),
    );
  }
}
