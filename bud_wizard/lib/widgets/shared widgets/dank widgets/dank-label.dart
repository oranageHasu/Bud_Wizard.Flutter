import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankLabel extends StatelessWidget {
  final String displayText;
  final double width;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final TextStyle textStyle;

  DankLabel({
    @required String displayText,
    double width,
    TextAlign textAlign = TextAlign.left,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    TextStyle textStyle = appLabelFontStyle,
  })  : this.displayText = displayText,
        this.width = width,
        this.textAlign = textAlign,
        this.padding = padding,
        this.textStyle = textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      child: Text(
        displayText,
        style: textStyle.copyWith(decoration: TextDecoration.none),
        textAlign: textAlign,
      ),
    );
  }
}
