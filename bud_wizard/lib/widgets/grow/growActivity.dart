import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GrowActivity extends StatefulWidget {
  final VoidCallback hoverBegins;
  final VoidCallback hoverEnds;

  GrowActivity({
    VoidCallback hoverBegins,
    VoidCallback hoverEnds,
  })  : this.hoverBegins = hoverBegins,
        this.hoverEnds = hoverEnds;

  @override
  _GrowActivityState createState() => _GrowActivityState();
}

class _GrowActivityState extends State<GrowActivity> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        if (!_isHovered) {
          _isHovered = true;

          if (widget.hoverBegins != null) {
            widget.hoverBegins();
          }
        }
      },
      onExit: (PointerExitEvent event) {
        if (_isHovered) {
          _isHovered = false;

          if (widget.hoverEnds != null) {
            widget.hoverEnds();
          }
        }
      },
      child: Container(
        width: 400.0,
        color: (currentTheme.isDarkTheme())
            ? appDarkTertiaryColor
            : appLightTertiaryColor,
        child: Column(
          children: [
            DankLabel(
              displayText: 'Recent Activity',
              textStyle: appLabelFontStyle.copyWith(
                color: appHintTextColor,
                fontWeight: FontWeight.bold,
              ),
              width: 375.0,
              textAlign: TextAlign.center,
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0.0,
              color: (currentTheme.currentTheme() == ThemeMode.dark)
                  ? appDarkSecondaryColor
                  : appLightSecondaryColor,
              margin: EdgeInsets.all(5.0),
              child: Container(
                height: 100.0,
                width: 375.0,
                child: Column(
                  children: [
                    DankLabel(
                      displayText: 'it\'s quiet for now...',
                      textStyle: appLabelFontStyle.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.only(
                        top: 10.0,
                      ),
                    ),
                    DankLabel(
                      displayText:
                          'When a grow related activity occurs - like another grower answering a question' +
                              ' or visiting your grow - we\'ll show it here!',
                      textStyle: appInputHintFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.only(
                        top: 5.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
