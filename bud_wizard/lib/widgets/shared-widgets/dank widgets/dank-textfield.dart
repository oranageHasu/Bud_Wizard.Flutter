import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';

class DankTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double minWidth;
  final double maxWidth;
  final bool isPassword;
  final Function(String) onSubmit;
  final FocusNode focusNode;
  final TextEditingController textController;

  DankTextField(
      {String labelText,
      String hintText,
      double minWidth,
      double maxWidth,
      bool isPassword,
      Function(String) onSubmit,
      FocusNode focusNode,
      TextEditingController textController})
      : this.labelText = labelText,
        this.hintText = hintText,
        this.minWidth = minWidth,
        this.maxWidth = maxWidth,
        this.isPassword = isPassword,
        this.onSubmit = onSubmit,
        this.focusNode = focusNode,
        this.textController = textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
      padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      child: TextField(
        controller: textController,
        onSubmitted: onSubmit,
        focusNode: focusNode,
        obscureText: isPassword,
        style: appInputFontStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
          hintText: hintText,
          labelText: labelText,
          labelStyle: appInputHintFontStyle,
          hintStyle: appInputHintFontStyle,
          prefixIcon: Icon(Icons.person, color: appBaseWhiteTextColor.shade700),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide:
                BorderSide(color: appBaseWhiteTextColor.shade300, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appBaseColor, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
