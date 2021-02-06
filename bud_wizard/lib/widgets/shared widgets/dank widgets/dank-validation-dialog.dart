import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
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
  _DankValidationDialogState createState() => _DankValidationDialogState();
}

class _DankValidationDialogState extends State<DankValidationDialog> {
  TextEditingController _validationTextController;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();
    _validationTextController = TextEditingController(text: '');

    if (widget.validationType == ValidationType.TextBasedValidation) {
      _isDisabled = true;
    }
  }

  @override
  void dispose() {
    _validationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: appBackgroundColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.all(0.0),
        width: 600.0,
        color: appBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DankLabel(
              displayText: widget.titleText,
              textStyle: appHeaderFontStyle,
              padding: EdgeInsets.only(
                top: 20.0,
              ),
            ),
            Divider(
              color: appTertiaryColor,
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DankLabel(
                    displayText: widget.messageText,
                    textStyle: appLabelFontStyle.copyWith(
                      fontSize: 16.0,
                    ),
                    padding: EdgeInsets.only(
                      top: 13.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            _buildValidationBody(),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 25.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DankButton(
                      buttonText: widget.okButtonText,
                      onPressed: () {
                        dismissDialog(context, true);
                      },
                      margin: EdgeInsets.only(right: 10.0),
                      padding: EdgeInsets.all(15.0),
                      isDisabled: _isDisabled,
                      buttonType: DankButtonType.Flat,
                      textColor: appBaseBlackTextColor,
                      borderRadius: 5.0,
                    ),
                    DankButton(
                      buttonText: widget.cancelButtonText,
                      onPressed: () {
                        dismissDialog(context, false);
                      },
                      margin: EdgeInsets.only(left: 10.0),
                      padding: EdgeInsets.all(15.0),
                      borderRadius: 5.0,
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

  Widget _buildValidationBody() {
    return Container(
      padding: EdgeInsets.all(50.0),
      child: (widget.validationType == ValidationType.TextBasedValidation)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 400.0),
                  child: TextField(
                    controller: _validationTextController,
                    style: appInputFontStyle,
                    onChanged: validateInput,
                    onSubmitted: validateAndSubmit,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Please type in "' +
                          widget.validationText +
                          '" to continue',
                      hintStyle: appInputHintFontStyle,
                      prefixIcon: Icon(
                        Icons.security,
                        color: appBaseWhiteTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBeforeAfterWidget('Before:', widget.beforeValue),
                _buildBeforeAfterWidget('After:', widget.afterValue),
              ],
            ),
    );
  }

  Widget _buildBeforeAfterWidget(
    String displayText,
    String value,
  ) {
    return Row(
      children: [
        Container(
          width: 100.0,
          padding: EdgeInsets.only(right: 10.0),
          child: DankLabel(
            displayText: displayText,
            textStyle: appLabelFontStyle,
            textAlign: TextAlign.end,
          ),
        ),
        Text(
          value,
          style: appValueLabelFontStyle,
        ),
      ],
    );
  }

  void validateAndSubmit(String value) {
    if (value == widget.validationText) {
      setState(() {
        _isDisabled = false;
      });

      dismissDialog(context, true);
    }
  }

  void validateInput(String value) {
    if (value == widget.validationText) {
      setState(() {
        _isDisabled = false;
      });
    } else if (!_isDisabled) {
      setState(() {
        _isDisabled = true;
      });
    }
  }

  void dismissDialog(BuildContext context, bool opResult) {
    Navigator.pop(context, opResult);
  }
}
