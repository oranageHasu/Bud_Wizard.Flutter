import 'package:bud_wizard/classes/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankLabel extends StatelessWidget {
  final String displayText;
  final double width;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double letterSpacing;

  DankLabel({
    @required String displayText,
    double width,
    TextAlign textAlign = TextAlign.left,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    TextStyle textStyle = appLabelFontStyle,
    double letterSpacing = 0.0,
  })  : this.displayText = displayText,
        this.width = width,
        this.textAlign = textAlign,
        this.padding = padding,
        this.textStyle = textStyle,
        this.letterSpacing = letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: (width != null) ? BoxConstraints(maxWidth: width) : null,
      padding: padding,
      child: Text(
        displayText,
        style: textStyle.copyWith(
          decoration: TextDecoration.none,
          letterSpacing: letterSpacing,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
