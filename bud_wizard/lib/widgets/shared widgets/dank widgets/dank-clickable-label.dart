import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankClickableLabel extends DankLabel {
  final VoidCallback onTapped;

  DankClickableLabel({
    @required String displayText,
    @required VoidCallback onTapped,
    double width,
    TextAlign textAlign = TextAlign.left,
    EdgeInsets padding = const EdgeInsets.all(0),
    TextStyle textStyle = appLabelFontStyle,
  })  : this.onTapped = onTapped,
        super(
          displayText: displayText,
          width: width,
          textAlign: textAlign,
          padding: padding,
          textStyle: textStyle,
        );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: (onTapped != null) ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: () {
          if (onTapped != null) {
            onTapped();
          }
        },
        child: super.build(context),
      ),
    );
  }
}
