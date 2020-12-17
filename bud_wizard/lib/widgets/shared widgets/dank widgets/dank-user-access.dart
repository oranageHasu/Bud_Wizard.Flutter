import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/sessionInfo.dart';
import 'package:bud_wizard/services/session-service.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:flutter/material.dart';

class DankUserAccess extends StatelessWidget {
  final Widget childHasAccess;
  final Widget childLacksAccess;
  final UserRole minAccessLevel;

  DankUserAccess({
    @required Widget childHasAccess,
    @required UserRole minAccessLevel,
    Widget childLacksAccess = const SizedBox.shrink(),
  })  : this.childHasAccess = childHasAccess,
        this.childLacksAccess = childLacksAccess,
        this.minAccessLevel = minAccessLevel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SessionInfo>(
      future: sessionInfo,
      builder: (context, snapshot) {
        Widget retval = childLacksAccess;

        if (snapshot.hasData) {
          /*
          if (userHasAccess(minAccessLevel, )) {
            retval = childHasAccess;
          }
          */
        } else if (snapshot.hasError) {
          return NoDataError();
        }

        return retval;
      },
    );
  }
}
