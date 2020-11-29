import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bud_wizard/classes/enumerations.dart';

import 'navigationTile.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              accountName:
                  Text("Oranagehasu", style: TextStyle(color: appBaseColor)),
              accountEmail: Text(
                "Oranagehasu@gmail.com",
                style: appLabelFontStyle,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX28408818.jpg'),
              ),
            ),
            Divider(height: 0.1, color: appThirdColor),
            NavigationTile(
              displayedText: "Grows",
              screen: Screen.grows,
              onTap: () {
                navigateTo(Screen.grows, context);
              },
            ),
            NavigationTile(
              displayedText: "Knowledge Base",
              screen: Screen.knowledgeBase,
              onTap: () {
                navigateTo(Screen.knowledgeBase, context);
              },
            ),
            Divider(height: 0.1, color: appThirdColor),
            NavigationTile(
              displayedText: "Messages",
              screen: Screen.messages,
              onTap: () {
                navigateTo(Screen.messages, context);
              },
            ),
            NavigationTile(
              displayedText: "Social Media",
              screen: Screen.social,
              onTap: () {
                navigateTo(Screen.social, context);
              },
            ),
            Divider(height: 0.1, color: appThirdColor),
            NavigationTile(
              displayedText: "Settings",
              screen: Screen.settings,
              onTap: () {
                navigateTo(Screen.settings, context);
              },
            ),
            Divider(height: 0.1, color: appThirdColor),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: NavigationTile(
                  displayedText: "Logout",
                  screen: Screen.login,
                  onTap: () {
                    performLogout(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void performLogout(BuildContext context) async {
    // To Do: Call API to perform logout

    // If successful? (we might not care) reroute the user to the Login
    Navigator.pushReplacementNamed(context, uiRouteLogin);
  }

  void navigateTo(Screen screen, BuildContext context) {
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
      default:
        route = uiRouteHomeScreen;
    }

    print('Routing to: ' + route);

    if (resetsScreenStack) {
      print('Route will reset the screen stack.');
      Navigator.pushReplacementNamed(context, route);
    } else {
      Navigator.pushNamed(context, route);
    }
  }
}
