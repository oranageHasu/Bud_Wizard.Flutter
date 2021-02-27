import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/services/api%20services/apiGrow.dart';
import 'package:bud_wizard/services/loggerService.dart';
import 'package:bud_wizard/widgets/grow/growPage.dart';
import 'package:bud_wizard/widgets/grow/growSearchDialog.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';

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
      width: 255.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: displaySearchDialog,
              child: Container(
                decoration: BoxDecoration(
                  color: appBaseWhiteTextColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 3.0,
                    ),
                    Icon(
                      Icons.search,
                      color: appHintTextColor,
                    ),
                    DankLabel(
                      displayText: 'Find other user\'s plants',
                      textStyle: appInputHintFontStyle.copyWith(
                        color: appBaseBlackTextColor.withOpacity(0.7),
                      ),
                      padding: EdgeInsets.all(7.5),
                    ),
                  ],
                ),
              ),
            ),
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

  void displaySearchDialog() async {
    bool opResult = await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.9),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: GrowSearchDialog(),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: Get.context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox(height: 20.0);
      },
    );

    if (opResult) {
      log('To Do: Do something post-search');
    }
  }
}
