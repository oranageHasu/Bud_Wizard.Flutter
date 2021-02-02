import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:flutter/material.dart';

class DankValidationDialogData {
  String titleText;
  String messageText;

  DankValidationDialogData({
    this.titleText,
    this.messageText,
  });
}

class DankValidationDialog extends StatefulWidget {
  final String titleText;
  final String messageText;
  final ValidationType validationType;
  final String validationText;
  final String beforeValue;
  final String afterValue;
  final String okButtonText;
  final String cancelButtonText;

  DankValidationDialog({
    @required this.titleText,
    @required this.messageText,
    @required this.validationType,
    this.validationText = '',
    this.beforeValue = '',
    this.afterValue = '',
    this.okButtonText = 'Verify',
    this.cancelButtonText = 'Undo',
  });

  @override
  _DankValidationDialogState createState() => _DankValidationDialogState(
        this.titleText,
        this.messageText,
        this.validationType,
        this.validationText,
        this.beforeValue,
        this.afterValue,
        this.okButtonText,
        this.cancelButtonText,
      );
}

class _DankValidationDialogState extends State<DankValidationDialog> {
  TextEditingController validationTextController;
  bool isDisabled = false;
  String titleText;
  String messageText;
  ValidationType validationType;
  String validationText;
  String beforeValue;
  String afterValue;
  String okButtonText;
  String cancelButtonText;

  _DankValidationDialogState(
    this.titleText,
    this.messageText,
    this.validationType,
    this.validationText,
    this.beforeValue,
    this.afterValue,
    this.okButtonText,
    this.cancelButtonText,
  );

  @override
  void initState() {
    super.initState();
    validationTextController = TextEditingController(text: '');

    if (validationType == ValidationType.TextBasedValidation) {
      isDisabled = true;
    }
  }

  @override
  void dispose() {
    validationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: appBaseBackgroundColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.all(0.0),
        width: 600.0,
        height: 400.0,
        color: appBaseBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text(
                titleText,
                style: appHeaderFontStyle,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 25.0,
              ),
              child: Divider(
                color: appThirdColor,
                thickness: 2.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: Text(
                messageText,
                style: appLabelFontStyle,
              ),
            ),
            SizedBox(height: 20),
            // Conditionally display either the validation textbox, or the before/after display
            (validationType == ValidationType.TextBasedValidation)
                ? Container(
                    height: 50.0,
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: validationTextController,
                          style: appInputFontStyle,
                          onChanged: validateInput,
                          onSubmitted: validateAndSubmit,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Please type in "' +
                                this.validationText +
                                '" to continue',
                            hintStyle: appInputHintFontStyle,
                            prefixIcon: Icon(Icons.security,
                                color: appBaseWhiteTextColor),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 50.0,
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100.0,
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(
                                'Before:',
                                style: appLabelFontStyle,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Text(beforeValue, style: appValueLabelFontStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100.0,
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(
                                'After:',
                                style: appLabelFontStyle,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Text(afterValue, style: appValueLabelFontStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 25.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DankButton(
                        buttonText: okButtonText,
                        onPressed: () {
                          dismissDialog(context, true);
                        },
                        margin: EdgeInsets.only(right: 10.0),
                        isDisabled: this.isDisabled,
                        buttonType: DankButtonType.Flat,
                      ),
                      DankButton(
                        buttonText: cancelButtonText,
                        onPressed: () {
                          dismissDialog(context, false);
                        },
                        margin: EdgeInsets.only(left: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndSubmit(String value) {
    if (value == this.validationText) {
      setState(() {
        this.isDisabled = false;
      });

      dismissDialog(context, true);
    }
  }

  void validateInput(String value) {
    // Conditionally set the disabled state of the "save" button
    if (value == this.validationText) {
      setState(() {
        this.isDisabled = false;
      });
    } else if (!this.isDisabled) {
      setState(() {
        this.isDisabled = true;
      });
    }
  }

  void dismissDialog(BuildContext context, bool opResult) {
    Navigator.pop(context, opResult);
  }
}
