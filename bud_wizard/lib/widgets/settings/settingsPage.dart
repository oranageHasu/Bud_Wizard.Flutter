import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-radio-button.dart';
import 'package:flutter/material.dart';

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
  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
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
              color: appThirdColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DankRadioButton(
                      id: 0,
                      currentIndex: (_isDarkMode) ? 1 : 0,
                      displayText: 'Light Mode',
                      onTapped: appColorModeChanged,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    DankRadioButton(
                      id: 1,
                      currentIndex: (_isDarkMode) ? 1 : 0,
                      displayText: 'Dark Mode',
                      onTapped: appColorModeChanged,
                    ),
                  ],
                ),
                TextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void appColorModeChanged(int index) {
    setState(() {
      _isDarkMode = index == 1;
    });

    currentTheme.switchTheme();
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
