import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/user%20system/loginPreferences.dart';
import 'package:bud_wizard/services/api%20services/apiLoginPreferences.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-radio-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingsPage extends StatefulWidget {
  static SettingsPageState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SettingsWidget>()
        .settingsData;
  }

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  Future<LoginPreferences> _loginPrefs;

  @override
  void initState() {
    super.initState();

    _loginPrefs = getLoginPreferences(
      userId: Guid('77c1e2cb-6792-4acd-ae31-3ab61a150822'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DankNavigator(
      currentScreen: Screen.Settings,
      content: SettingsWidget(
        settingsData: this,
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appDarkTertiaryColor
                  : appLightTertiaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
              ),
              boxShadow: (currentTheme.currentTheme() == ThemeMode.light)
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 10.0,
                        blurRadius: 25.0,
                      ),
                    ]
                  : null,
            ),
            child: FutureBuilder<LoginPreferences>(
              future: _loginPrefs,
              builder: (context, snapshot) {
                Widget retval = Center(
                  child: SpinKitRipple(
                    size: 200.0,
                    color: appBaseColor,
                    duration: Duration(milliseconds: 2500),
                  ),
                );

                if (snapshot.hasData) {
                  retval = _buildBody(snapshot.data);
                } else if (snapshot.hasError) {
                  retval = Center(
                    child: DankLabel(
                      displayText:
                          'Sorry.  We fucked up.  Someone is working on it.',
                    ),
                  );
                }

                return retval;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(LoginPreferences locPrefs) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: (currentTheme.currentTheme() == ThemeMode.dark)
            ? appDarkTertiaryColor
            : appLightTertiaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
        ),
        boxShadow: (currentTheme.currentTheme() == ThemeMode.light)
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 10.0,
                  blurRadius: 25.0,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DankLabel(
                displayText: 'Dark Mode:',
              ),
              Switch(
                value: locPrefs.prefersDarkMode,
                onChanged: (value) {
                  setState(() {
                    locPrefs.prefersDarkMode = value;
                  });

                  putLocationPreferences(locPrefs);

                  currentTheme.switchTheme();
                },
                activeTrackColor: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsWidget extends InheritedWidget {
  final SettingsPageState settingsData;

  SettingsWidget({
    Key key,
    @required Widget child,
    @required this.settingsData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(SettingsWidget oldWidget) {
    return true;
  }
}
