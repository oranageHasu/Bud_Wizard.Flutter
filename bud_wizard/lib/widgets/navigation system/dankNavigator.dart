import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/sessionInfo.dart';
import 'package:bud_wizard/services/api%20services/apiLoginPreferences.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankAppBar.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankOperationPanel.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:flutter/material.dart';

class DankNavigator extends StatefulWidget {
  final Widget content;
  final Screen currentScreen;

  DankNavigator({
    @required Widget content,
    @required Screen currentScreen,
  })  : this.content = content,
        this.currentScreen = currentScreen;

  @override
  _DankNavigatorState createState() => _DankNavigatorState();
}

class _DankNavigatorState extends State<DankNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                DankOperationPanel(currentScreen: widget.currentScreen),
                FutureBuilder<SessionInfo>(
                  future: sessionInfo,
                  builder: (context, snapshot) {
                    Widget retval = SizedBox.shrink();

                    if (snapshot.hasData) {
                      getLoginPreferences(userId: snapshot.data.user.userId)
                          .then(
                        (value) => {
                          // To Do: Change the theme
                        },
                      );

                      retval = widget.content;
                    }

                    return retval;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
