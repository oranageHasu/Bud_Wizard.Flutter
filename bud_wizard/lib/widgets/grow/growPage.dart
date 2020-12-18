import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api%20services/api-grow.dart';
import 'package:bud_wizard/widgets/grow/growPageBody.dart';
import 'package:bud_wizard/widgets/grow/growPageHeader.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class GrowPage extends StatefulWidget {
  static GrowPageState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GrowWidget>().growsData;
  }

  @override
  State<StatefulWidget> createState() => GrowPageState();
}

class GrowPageState extends State<GrowPage> {
  Future<List<Grow>> _grows;
  Grow _currentGrow;

  void setGrows(Future<List<Grow>> grows) {
    setState(() {
      _grows = grows;
    });
  }

  void setCurrentGrow(Grow grow) {
    setState(() {
      _currentGrow = grow;
    });
  }

  @override
  void initState() {
    super.initState();
    _grows = getGrows(new Guid('77c1e2cb-6792-4acd-ae31-3ab61a150822'));
  }

  @override
  Widget build(BuildContext context) {
    return DankNavigator(
      currentScreen: Screen.Grows,
      content: GrowWidget(
        growsData: this,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                GrowPageHeader(),
                Divider(
                  color: appBaseContentBackgroundColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
                GrowPageBody(
                  grows: _grows,
                  currentGrow: _currentGrow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GrowWidget extends InheritedWidget {
  final GrowPageState growsData;

  GrowWidget({
    Key key,
    @required Widget child,
    @required this.growsData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(GrowWidget oldWidget) {
    return true;
  }
}
