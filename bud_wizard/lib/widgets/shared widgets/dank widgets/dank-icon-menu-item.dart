import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-menu.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class DankIconMenuItem extends StatefulWidget {
  final IconMenuItem menuItem;
  final VoidCallback closeMenu;

  const DankIconMenuItem({
    @required IconMenuItem menuItem,
    @required VoidCallback closeMenu,
  })  : this.menuItem = menuItem,
        this.closeMenu = closeMenu;

  @override
  _DankIconMenuItemState createState() => _DankIconMenuItemState(
        this.menuItem,
        this.closeMenu,
      );
}

class _DankIconMenuItemState extends State<DankIconMenuItem> {
  IconMenuItem menuItem;
  VoidCallback closeMenu;

  bool _isHovered = false;

  _DankIconMenuItemState(
    this.menuItem,
    this.closeMenu,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (menuItem.onSelected != null) {
          menuItem.onSelected();
        }

        closeMenu();
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Container(
          height: 50.0,
          color: (_isHovered)
              ? (currentTheme.currentTheme() == ThemeMode.dark)
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05)
              : (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appDarkBackgroundColor
                  : appLightBackgroundColor,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                menuItem.icon,
                color: appBaseColor,
                size: 25.0,
              ),
              DankLabel(
                displayText: menuItem.displayText,
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
        ),
      ),
    );
  }
}
