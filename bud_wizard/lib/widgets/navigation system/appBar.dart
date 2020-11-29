import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';

class DankAppBar extends StatefulWidget implements PreferredSizeWidget {
  DankAppBar({Key key, String title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        title = title,
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final String title;

  @override
  _DankAppBarState createState() => _DankAppBarState(title: title);
}

class _DankAppBarState extends State<DankAppBar> {
  final String title;

  _DankAppBarState({String title}) : this.title = title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: appHeaderFontStyle),
      backgroundColor: appBaseContentBackgroundColor,
      iconTheme: IconThemeData(
        color: appBaseColor,
      ),
    );
  }
}
