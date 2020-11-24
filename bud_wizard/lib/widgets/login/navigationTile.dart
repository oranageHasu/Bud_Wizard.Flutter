import 'package:bud_wizard/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bud_wizard/classes/enumerations.dart';

import '../../main.dart';

class NavigationTile extends StatelessWidget {

  final String displayedText;
  final Screen screen;

  NavigationTile({
    String displayedText,
    Screen screen
  }):
        this.displayedText = displayedText,
        this.screen = screen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(displayedText, style: TextStyle(color: Colors.white)),
      leading: new Icon(getIcon(), color: colorCustom),
      hoverColor: Colors.green,
      tileColor: Colors.transparent,
      onTap: () {

        String route;
        bool resetsScreenStack = false;

        switch (screen) {
          case Screen.messages:
            route = uiRouteMessages;
            break;
          case Screen.grows:
            route = uiRouteGrows;
            break;
          case Screen.social:
            route = uiRouteSocial;
            break;
          case Screen.knowledgeBase:
            route = uiRouteKnowledgeBase;
            break;
          case Screen.settings:
            route = uiRouteSettings;
            break;
          default: route = uiRouteGrows;
        }

        print('Routing to: ' + route);

        if (resetsScreenStack) {

          print('Route will reset the screen stack.');
          Navigator.pushReplacementNamed(context, route);

        } else {
          Navigator.pushNamed(context, route);
        }

      },
    );
  }

  IconData getIcon() {

    switch (screen) {
      case Screen.messages: return Icons.mail;
      case Screen.grows: return Icons.self_improvement_rounded;
      case Screen.social: return Icons.people;
      case Screen.knowledgeBase: return Icons.info;
      case Screen.settings: return Icons.settings;
      default: return Icons.add_alert;
    }

  }
}