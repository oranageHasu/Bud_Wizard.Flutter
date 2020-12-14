import 'package:bud_wizard/classes/app-theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DankTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double minWidth;
  final double maxWidth;
  final bool isPassword;
  final Function(String) onSubmit;
  final Function(String) onChanged;
  final Function(String) onLostFocus;
  final Function(String) onValidate;
  final FocusNode focusNode;
  final TextEditingController textController;
  final Icon prefixIcon;
  final bool autofocus;
  final EdgeInsets margin;
  final EdgeInsets textPadding;
  final int maxTextCharacters;
  final bool displayMaxCharacterValidation;
  final bool digitsOnly;
  final double borderRadius = 10.0;
  final Color borderColorUnselected;

  DankTextField({
    String labelText = '',
    String hintText = '',
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    bool isPassword = false,
    Function(String) onSubmit,
    Function(String) onChanged,
    Function(String) onLostFocus,
    Function(String) onValidate,
    FocusNode focusNode,
    TextEditingController textController,
    Icon prefixIcon = const Icon(null),
    bool autofocus = false,
    EdgeInsets margin = const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    EdgeInsets textPadding = const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    int maxTextCharacters = 25,
    bool displayMaxCharacterValidation = false,
    bool digitsOnly = false,
    Color borderColorUnselected = Colors.transparent,
  })  : this.labelText = labelText,
        this.hintText = hintText,
        this.minWidth = minWidth,
        this.maxWidth = maxWidth,
        this.isPassword = isPassword,
        this.onSubmit = onSubmit,
        this.onChanged = onChanged,
        this.onLostFocus = onLostFocus,
        this.onValidate = onValidate,
        this.focusNode = focusNode,
        this.textController = textController,
        this.prefixIcon = prefixIcon,
        this.autofocus = autofocus,
        this.margin = margin,
        this.textPadding = textPadding,
        this.maxTextCharacters = maxTextCharacters,
        this.displayMaxCharacterValidation = displayMaxCharacterValidation,
        this.digitsOnly = digitsOnly,
        this.borderColorUnselected = borderColorUnselected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
      margin: margin,
      child: Focus(
        skipTraversal: true,
        onFocusChange: (hasFocus) {
          if (!hasFocus && onLostFocus != null) {
            onLostFocus(textController.value.text);
          }
        },
        child: TextFormField(
          controller: textController,
          focusNode: focusNode,
          obscureText: isPassword,
          style: appInputFontStyle,
          autofocus: autofocus,
          onFieldSubmitted: onSubmit,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            contentPadding: textPadding,
            hintText: hintText,
            labelText: labelText,
            labelStyle: appInputLabelFontStyle,
            hintStyle: appInputHintFontStyle,
            prefixIcon: prefixIcon,
            counterStyle: appInputCounterFontStyle,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColorUnselected, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appBaseColor, width: 2.0),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appErrorColor, width: 3.0),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorStyle: appErrorFontStyle,
          ),
          validator: onValidate,
          maxLength: (displayMaxCharacterValidation) ? maxTextCharacters : null,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxTextCharacters),
            if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }
}
