import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api-services.dart';
import 'package:bud_wizard/widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/login/navigation.dart';
import 'package:bud_wizard/widgets/shared-widgets/screenHeader.dart';
import 'package:flutter/material.dart';

import 'growCard.dart';

class GrowsPage extends StatefulWidget {

  @override
  _GrowsPageState createState() => _GrowsPageState();

}

class _GrowsPageState extends State<GrowsPage> {

  bool _error = false;
  Future<List<Grow>> _grows;

  @override
  void initState() {
    super.initState();
    _grows = getGrows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bud Wizard'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FadeIn(1.0, ScreenHeader(title: 'Grows')),
            FutureBuilder<List<Grow>> (
                future: _grows,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    return Column(
                        children: <Widget>[
                          for (Grow grow in snapshot.data) FadeIn(3.0, GrowCard(grow: grow))
                        ]
                    );
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();

                }
            ),
          ],
        ),
      ),
      drawer: Navigation(),
    );
  }
}