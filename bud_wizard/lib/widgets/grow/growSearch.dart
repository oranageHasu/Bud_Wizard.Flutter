import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/services/api%20services/api-grow.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class GrowSearch extends StatefulWidget {
  @override
  GrowSearchState createState() => GrowSearchState();
}

class GrowSearchState extends State<GrowSearch> {
  TextEditingController searchboxController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            onChanged: searchTextChanged,
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
    Future<List<Grow>> grows = getGrows(
        new Guid('77c1e2cb-6792-4acd-ae31-3ab61a150822'),
        searchText: text);

    // Tell the parent its data has changed and force a re-render
    GrowPage.of(context).setGrows(grows);
  }
}
