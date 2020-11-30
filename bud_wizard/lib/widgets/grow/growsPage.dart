import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/navigation%20system/appBar.dart';
import 'package:bud_wizard/widgets/navigation%20system/navigation.dart';
import 'package:bud_wizard/widgets/shared-widgets/dank%20widgets/dank-display-label.dart';
import 'package:bud_wizard/widgets/shared-widgets/dank%20widgets/dank-icon-button.dart';
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
    return Scaffold(
      appBar: DankAppBar(title: 'Grows'),
      body: growsPageBody(context),
      drawer: Navigation(),
      backgroundColor: appBaseBackgroundColor,
    );
  }

  Widget growsPageBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    featuredGrow(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget featuredGrow() {
    return Material(
      elevation: 15.0,
      color: Colors.transparent,
      child: Container(
        height: 300.0,
        padding: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            border: Border.all(color: appThirdColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
                child: Image.asset(
                  "panama-red.jpg",
                  height: 300.0,
                  width: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
              FutureBuilder<List<Grow>>(
                future: _grows,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            snapshot.data[0].name,
                            style: appHeaderLabelFontStyle,
                          ),
                          DankDisplayLabel(
                            label: 'Started: ',
                            value: formatDate(snapshot.data[0].startDate),
                          ),
                          DankDisplayLabel(
                            label: 'Location:',
                            value:
                                formatEnum(snapshot.data[0].setting.toString()),
                          ),
                        ],
                      ),
                    );
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
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
