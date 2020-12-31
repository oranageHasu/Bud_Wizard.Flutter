import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class DankPopupMenu extends StatelessWidget {
  final List<DankDropdownItem> items;
  final EdgeInsets margin;

  DankPopupMenu({
    @required List<DankDropdownItem> items,
    EdgeInsets margin = const EdgeInsets.all(0.0),
  })  : this.items = items,
        this.margin = margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: PopupMenuButton<DankDropdownItem>(
        itemBuilder: buildDropDownMenuItems,
        color: appBaseBackgroundColor,
        offset: const Offset(0.0, 50.0),
        icon: new Icon(
          Icons.account_circle,
          color: appBaseWhiteTextColor,
          size: 35.0,
        ),
        onSelected: (selectedItem) {
          selectedItem.onSelected(context);
        },
      ),
    );
  }

  List<PopupMenuEntry<DankDropdownItem>> buildDropDownMenuItems(
    BuildContext context,
  ) {
    List<PopupMenuEntry<DankDropdownItem>> retval = List();

    for (DankDropdownItem item in items) {
      retval.add(
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                item.icon,
                color: appBaseColor,
                size: 25.0,
              ),
              DankLabel(
                displayText: item.displayText,
                textAlign: TextAlign.start,
                textStyle: appLabelFontStyle.copyWith(
                  fontSize: 14.0,
                ),
                padding: EdgeInsets.only(
                  left: 10.0,
                ),
              ),
            ],
          ),
          value: item,
        ),
      );
    }

    return retval;
  }
}

class DankDropdownItem {
  String displayText;
  IconData icon;
  Function(BuildContext context) onSelected;

  DankDropdownItem(
    this.displayText,
    this.icon,
    this.onSelected,
  );
}
