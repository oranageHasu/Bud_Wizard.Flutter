import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bud_wizard/classes/enumerations.dart';

class NavigationTile extends StatelessWidget {
  final String displayedText;
  final Screen screen;
  final VoidCallback onTap;

  NavigationTile({String displayedText, Screen screen, VoidCallback onTap})
      : this.displayedText = displayedText,
        this.screen = screen,
        this.onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(displayedText, style: appLabelFontStyle),
      leading: new Icon(getIcon(), color: appBaseColor),
      hoverColor: Colors.black,
      tileColor: Colors.transparent,
      onTap: onTap,
    );
  }

  IconData getIcon() {
    switch (screen) {
      case Screen.messages:
        return Icons.mail;
      case Screen.grows:
        return Icons.self_improvement_rounded;
      case Screen.social:
        return Icons.people;
      case Screen.knowledgeBase:
        return Icons.info;
      case Screen.settings:
        return Icons.settings;
      case Screen.login:
        return Icons.logout;
      default:
        return Icons.add_alert;
    }
  }
}
