import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-menu-item.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicTooltip.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/utils/menuBoxClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IconMenuItem {
  String displayText;
  IconData icon;
  VoidCallback onSelected;

  IconMenuItem(
    this.displayText,
    this.icon,
    this.onSelected,
  );
}

class DankIconMenu extends StatefulWidget {
  final List<IconMenuItem> menuItems;
  final IconData icon;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Widget menuHeaderChild;

  const DankIconMenu({
    Key key,
    @required List<IconMenuItem> menuItems,
    @required IconData icon,
    @required Color iconColor,
    double borderRadius = 5.0,
    Color backgroundColor = const Color(0xFFF67C0B9),
    Color borderColor = Colors.black,
    Widget menuHeaderChild,
  })  : this.menuItems = menuItems,
        this.icon = icon,
        this.iconColor = iconColor,
        this.borderRadius = borderRadius,
        this.backgroundColor = backgroundColor,
        this.borderColor = borderColor,
        this.menuHeaderChild = menuHeaderChild,
        super(key: key);

  @override
  _DankIconMenuState createState() => _DankIconMenuState(
        this.menuItems,
        this.icon,
        this.borderRadius,
        this.borderColor,
        this.menuHeaderChild,
      );
}

class _DankIconMenuState extends State<DankIconMenu>
    with SingleTickerProviderStateMixin {
  List<IconMenuItem> menuItems;
  IconData icon;
  double borderRadius;
  Color borderColor;
  Widget menuHeaderChild;

  bool _isMenuOpen = false;
  bool _isMenuHovered = false;
  Offset _buttonPosition;
  Size _buttonSize;
  GlobalKey _key;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;

  final double _menuWidth = 225.0;

  _DankIconMenuState(
    this.menuItems,
    this.icon,
    this.borderRadius,
    this.borderColor,
    this.menuHeaderChild,
  );

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _key = LabeledGlobalKey("button_icon");
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    _buttonSize = renderBox.size;
    _buttonPosition = renderBox.localToGlobal(Offset.fromDirection(0, -175.0));
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();

    _isMenuOpen = !_isMenuOpen;
  }

  void openMenu() {
    findButton();

    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();

    Overlay.of(context).insert(_overlayEntry);

    _isMenuOpen = !_isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isMenuHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isMenuHovered = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: DankBasicTooltip(
        tooltipText: 'Click to display this menu',
        child: GestureDetector(
          onTap: () {
            if (_isMenuOpen) {
              closeMenu();
            } else {
              openMenu();
            }
          },
          child: Container(
            key: _key,
            padding: EdgeInsets.only(right: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  icon,
                  color: (_isMenuHovered)
                      ? widget.iconColor.withOpacity(0.4)
                      : widget.iconColor,
                  size: 35.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: appHintTextColor,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            closeMenu();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.1),
            child: Stack(
              children: [
                Positioned(
                  top: _buttonPosition.dy + _buttonSize.height - 16,
                  left: _buttonPosition.dx,
                  width: _menuWidth,
                  child: Material(
                    color: Colors.transparent,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.5),
                          child: Material(
                            color: Colors.transparent,
                            shadowColor: appBaseColor,
                            child: Container(
                              width: _menuWidth,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: (currentTheme.currentTheme() ==
                                        ThemeMode.dark)
                                    ? appDarkBackgroundColor
                                    : appLightBackgroundColor,
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  header(),
                                  for (IconMenuItem menuItem in menuItems)
                                    DankIconMenuItem(
                                      menuItem: menuItem,
                                      closeMenu: closeMenu,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          widthFactor: 12.0,
                          child: ClipPath(
                            clipper: MenuBoxClipper(),
                            child: Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                color: (currentTheme.currentTheme() ==
                                        ThemeMode.dark)
                                    ? appDarkBackgroundColor
                                    : appLightBackgroundColor,
                              ),
                            ),
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
      },
    );
  }

  Widget header() {
    return (menuHeaderChild != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              menuHeaderChild,
              Divider(
                color: borderColor,
                thickness: 1.5,
              )
            ],
          )
        : SizedBox.shrink();
  }
}
