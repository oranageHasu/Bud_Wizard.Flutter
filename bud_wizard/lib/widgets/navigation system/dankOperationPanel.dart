import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/services/api%20services/api-login.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankOperationButton.dart';
import 'package:flutter/material.dart';

class DankOperationPanel extends StatefulWidget {
  final Screen currentScreen;

  DankOperationPanel({
    @required Screen currentScreen,
  }) : this.currentScreen = currentScreen;

  static DankOperationPanelState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DankOperationPanelWidget>()
        .opPanelData;
  }

  @override
  State<StatefulWidget> createState() =>
      DankOperationPanelState(this.currentScreen);
}

class DankOperationPanelState extends State<DankOperationPanel> {
  Screen currentScreen;

  DankOperationPanelState(
    this.currentScreen,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If the parent propogated a change, reflect it in this component
    //<ParentBodyState> data = <ParentBodyState>.of(context);
    print(
        'To Do: Implement "didChangeDependencies" for DankOperationPanel widget.');
  }

  @override
  Widget build(BuildContext context) {
    return DankOperationPanelWidget(
      child: Container(
        width: 100.0,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DankOperationButton(
              tooltipText: 'Bud Wizard News',
              icon: Icons.home,
              isSelected: isScreenSelected(Screen.Home),
              screen: Screen.Home,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 27.0),
              child: Divider(
                color: appThirdColor,
                thickness: 2.0,
              ),
            ),
            DankOperationButton(
              tooltipText: 'Your personal grows',
              icon: Icons.grass,
              isSelected: isScreenSelected(Screen.Grows),
              screen: Screen.Grows,
            ),
            DankOperationButton(
              tooltipText: 'Share your grows',
              icon: Icons.share,
              isSelected: isScreenSelected(Screen.Social),
              screen: Screen.Social,
            ),
            DankOperationButton(
              tooltipText: 'A vast growers knowledge base',
              icon: Icons.menu_book,
              isSelected: isScreenSelected(Screen.KnowledgeBase),
              screen: Screen.KnowledgeBase,
            ),
            DankOperationButton(
              tooltipText: 'App Settings',
              icon: Icons.settings,
              isSelected: isScreenSelected(Screen.Settings),
              screen: Screen.Settings,
            ),
            Expanded(
              child: SizedBox(width: 120.0),
            ),
            DankOperationButton(
              tooltipText: 'Logout',
              icon: Icons.logout,
              isSelected: isScreenSelected(Screen.Login),
              screen: Screen.Login,
            ),
          ],
        ),
      ),
      opPanelData: this,
    );
  }

  bool isScreenSelected(Screen screen) {
    return this.currentScreen == screen;
  }

  void navigateTo(Screen screen) {
    String route;
    bool resetsScreenStack = false;

    if (screen != Screen.Login) {
      switch (screen) {
        case Screen.Messages:
          route = uiRouteMessages;
          break;
        case Screen.Grows:
          route = uiRouteGrows;
          break;
        case Screen.Social:
          route = uiRouteSocial;
          break;
        case Screen.KnowledgeBase:
          route = uiRouteKnowledgeBase;
          break;
        case Screen.Settings:
          route = uiRouteSettings;
          break;
        case Screen.Login:
          route = uiRouteLogin;
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

      setState(() {
        this.currentScreen = screen;
      });
    } else {
      performLogout();
    }
  }

  void performLogout() async {
    // Call API to perform logout
    bool opResult = await logout();

    // If successful? (we might not care) reroute the user to the Login
    if (opResult) {
      Navigator.pushReplacementNamed(context, uiRouteLogin);
    }
  }
}

class DankOperationPanelWidget extends InheritedWidget {
  final DankOperationPanelState opPanelData;

  DankOperationPanelWidget({
    Key key,
    @required Widget child,
    @required this.opPanelData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DankOperationPanelWidget oldWidget) {
    return true;
  }
}
