import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api%20services/api-grow.dart';
import 'package:bud_wizard/widgets/grow/growSearch.dart';
import 'package:bud_wizard/widgets/grow/growSelector.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class GrowsPage extends StatefulWidget {
  static GrowsPageState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GrowsWidget>().growsData;
  }

  @override
  State<StatefulWidget> createState() => GrowsPageState();
}

class GrowsPageState extends State<GrowsPage> {
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
      content: GrowsWidget(
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
                growsPageHeader(),
                Divider(
                  color: appBaseContentBackgroundColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
                growsPageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget growsPageHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 0.0),
      decoration: BoxDecoration(
        color: appThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GrowSearch(),
            Expanded(
              child: Container(
                color: appSecondColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: DankLabel(
                        displayText: 'Plants',
                        textStyle: appLabelFontStyle,
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                        left: 25.0,
                        right: 15.0,
                      ),
                      child: VerticalDivider(
                        color: appThirdColor,
                        width: 1.0,
                        thickness: 2.0,
                      ),
                    ),
                    Center(
                      child: DankLabel(
                        displayText: 'Questions',
                        textStyle:
                            appLabelFontStyle.copyWith(color: appHintTextColor),
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                    ),
                    Center(
                      child: DankLabel(
                        displayText: 'Statistics',
                        textStyle:
                            appLabelFontStyle.copyWith(color: appHintTextColor),
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget growsPageBody() {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Grow>>(
            future: _grows,
            builder: (context, snapshot) {
              Widget retval = loading();

              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  retval = noData();
                } else {
                  if (_currentGrow == null) {
                    _currentGrow = snapshot.data[0];
                  }

                  retval = GrowSelector(
                    grows: snapshot.data,
                    currentGrow: _currentGrow,
                  );
                }
              } else if (snapshot.hasError) {
                return NoDataError();
              }

              return retval;
            },
          ),
          Expanded(
            child: Container(
              color: appSecondColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: 320.0,
          margin: EdgeInsets.all(10.0),
          child: DankLoading(),
        ),
      ],
    );
  }

  Widget noData() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: 320.0,
          margin: EdgeInsets.all(10.0),
          child: DankLabel(
            displayText: 'No Data Found',
            textStyle: appInputHintFontStyle.copyWith(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            padding: EdgeInsets.only(
              top: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}

class GrowsWidget extends InheritedWidget {
  final GrowsPageState growsData;

  GrowsWidget({
    Key key,
    @required Widget child,
    @required this.growsData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(GrowsWidget oldWidget) {
    return true;
  }
}
