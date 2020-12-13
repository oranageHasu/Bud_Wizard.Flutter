import 'package:bud_wizard/classes/constants.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/classes/formatter.dart';
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
        padding: EdgeInsets.only(
          top: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            DankOperationButton(
              tooltipText: 'Bud Wizard News',
              icon: Icons.home,
              screen: Screen.Home,
            ),
            DankOperationButton(
              tooltipText: 'Your personal grows',
              icon: Icons.self_improvement_rounded,
              screen: Screen.Grows,
            ),
            DankOperationButton(
              tooltipText: 'Share your grows',
              icon: Icons.people,
              screen: Screen.Social,
            ),
            DankOperationButton(
              tooltipText: 'A vast growers knowledge base',
              icon: Icons.info_outline_rounded,
              screen: Screen.KnowledgeBase,
            ),
            DankOperationButton(
              tooltipText: 'Logout',
              icon: Icons.logout,
              screen: Screen.Login,
            ),
          ],
        ),
      ),
      opPanelData: this,
    );
  }

  void navigateTo(Screen screen) {
    String route;
    bool resetsScreenStack = false;

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
