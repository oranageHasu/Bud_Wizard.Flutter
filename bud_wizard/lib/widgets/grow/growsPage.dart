import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/grow/growCard.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankNavigator.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';

class GrowsPage extends StatefulWidget {
  @override
  _GrowsPageState createState() => _GrowsPageState();
}

class _GrowsPageState extends State<GrowsPage> {
  Future<List<Grow>> _grows;

  @override
  void initState() {
    super.initState();
    _grows = getGrows();
  }

  @override
  Widget build(BuildContext context) {
    return DankNavigator(
      currentScreen: Screen.Grows,
      content: Expanded(
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
            growsSearch(),
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
                        top: 10.0,
                        bottom: 10.0,
                        left: 25.0,
                        right: 25.0,
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

  Widget growsSearch() {
    TextEditingController searchboxController = new TextEditingController();

    return Container(
      width: 320.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DankTextField(
            textController: searchboxController,
            onSubmit: (value) {
              print('To Do: GrowsSearch onSubmit.');
            },
            labelText: 'Find a grow',
            hintText: 'Type keywords to perform a search',
            minWidth: 320,
            maxWidth: 320,
            prefixIcon: Icon(
              Icons.search,
              color: appBaseWhiteTextColor,
            ),
            margin: EdgeInsets.all(0.0),
          ),
        ],
      ),
    );
  }

  void searchTextChanged(text) {
    print('To Do: GrowSearch text changed.');
  }

  Widget growsPageBody() {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          growsSelector(),
          Expanded(
            child: Container(
              color: appSecondColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget growsSelector() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: 320.0,
          margin: EdgeInsets.all(10.0),
          child: FutureBuilder<List<Grow>>(
            future: _grows,
            builder: (context, snapshot) {
              // If we're ready with data
              if (snapshot.hasData) {
                return Column(
                  children: [
                    for (Grow grow in snapshot.data)
                      GrowCard(
                        grow: grow,
                        tooltipText: 'Click to see this Grow',
                        isSelected: (grow.name == 'First Grow'),
                      ),
                  ],
                );
              }

              // By default, show a loading spinner.
              return Padding(
                padding: EdgeInsets.only(
                  top: 30.0,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void addGrow() {
    print("To Do: Add Grow.");
  }
}
/*
Center(
        
        child: Column(
          
          children: <Widget>[
            SlideIn(1.0, ScreenHeader(title: 'Grows')),
            FutureBuilder<List<Grow>>(
                future: _grows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: <Widget>[
                      for (Grow grow in snapshot.data)
                        SlideIn(3.0, GrowCard(grow: grow))
                    ]);
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
      drawer: Navigation(),
      backgroundColor: Colors.black87,
      */
