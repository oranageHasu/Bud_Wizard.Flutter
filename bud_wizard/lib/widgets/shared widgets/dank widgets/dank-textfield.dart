import 'package:bud_wizard/classes/appTheme.dart';
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
  final VoidCallback onFocus;
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
  final Color selectedBorderColor;
  final Color textColor;
  final Color hintTextColor;
  final Color unselectedBorderColor;
  final TextInputType keybordType;
  final int maxLines;

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
    VoidCallback onFocus,
    FocusNode focusNode,
    TextEditingController textController,
    Icon prefixIcon,
    bool autofocus = false,
    EdgeInsets margin = const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    EdgeInsets textPadding = const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    int maxTextCharacters = 25,
    bool displayMaxCharacterValidation = false,
    bool digitsOnly = false,
    TextInputType keybordType = TextInputType.text,
    int maxLines = 1,
    Color selectedBorderColor,
    Color textColor,
    Color hintTextColor,
    Color unselectedBorderColor = appUnselectedColor,
  })  : this.labelText = labelText,
        this.hintText = hintText,
        this.minWidth = minWidth,
        this.maxWidth = maxWidth,
        this.isPassword = isPassword,
        this.onSubmit = onSubmit,
        this.onChanged = onChanged,
        this.onLostFocus = onLostFocus,
        this.onValidate = onValidate,
        this.onFocus = onFocus,
        this.focusNode = focusNode,
        this.textController = textController,
        this.prefixIcon = prefixIcon,
        this.autofocus = autofocus,
        this.margin = margin,
        this.textPadding = textPadding,
        this.maxTextCharacters = maxTextCharacters,
        this.displayMaxCharacterValidation = displayMaxCharacterValidation,
        this.digitsOnly = digitsOnly,
        this.keybordType = keybordType,
        this.maxLines = maxLines,
        this.selectedBorderColor = selectedBorderColor,
        this.textColor = textColor,
        this.hintTextColor = hintTextColor,
        this.unselectedBorderColor = unselectedBorderColor;

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
          } else if (onFocus != null) {
            onFocus();
          }
        },
        child: TextFormField(
          keyboardType: keybordType,
          maxLines: maxLines,
          controller: textController,
          focusNode: focusNode,
          obscureText: isPassword,
          style: appInputFontStyle.copyWith(
            color: (textColor != null)
                ? textColor
                : (currentTheme.currentTheme() == ThemeMode.dark)
                    ? appBaseWhiteTextColor
                    : appBaseBlackTextColor,
          ),
          autofocus: autofocus,
          onFieldSubmitted: onSubmit,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: textPadding,
            hintText: hintText,
            labelText: labelText,
            labelStyle: appInputLabelFontStyle.copyWith(
              color: (textColor != null)
                  ? textColor
                  : (currentTheme.currentTheme() == ThemeMode.dark)
                      ? appBaseWhiteTextColor.withOpacity(0.7)
                      : appHintTextColor.withOpacity(0.7),
            ),
            alignLabelWithHint:
                (keybordType == TextInputType.multiline) ? true : false,
            hintStyle: appInputHintFontStyle.copyWith(
              color: (hintTextColor != null)
                  ? hintTextColor
                  : (currentTheme.currentTheme() == ThemeMode.dark)
                      ? appBaseWhiteTextColor
                      : appHintTextColor,
            ),
            prefixIcon: prefixIcon,
            counterStyle: appInputCounterFontStyle,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: appUnselectedColor, width: 2.0),
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
