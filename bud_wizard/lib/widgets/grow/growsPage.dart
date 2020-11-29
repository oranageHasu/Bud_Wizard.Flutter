import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/navigation%20system/appBar.dart';
import 'package:bud_wizard/widgets/navigation%20system/navigation.dart';
import 'package:bud_wizard/widgets/shared-widgets/animations/slideIn.dart';
import 'package:bud_wizard/widgets/shared-widgets/screenHeader.dart';
import 'package:flutter/material.dart';

import 'growCard.dart';

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
      body: Center(
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
    );
  }
}
