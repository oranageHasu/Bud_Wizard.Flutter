import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/navigation%20system/unknownRoute.dart';
import 'package:flutter/material.dart';

class UnknownRoutePage extends StatefulWidget {
  @override
  _UnknownRoutePageState createState() => _UnknownRoutePageState();
}

class _UnknownRoutePageState extends State<UnknownRoutePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: DankAppBar(title: 'Unhandled Screen'),
      body: UnknownRoute(),
      //drawer: Navigation(),
      backgroundColor: appBackgroundColor,
    );
  }
}
