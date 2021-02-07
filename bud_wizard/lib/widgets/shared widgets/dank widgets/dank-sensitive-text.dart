import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-tooltip.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankValidationDialog.dart';
import 'package:flutter/material.dart';

// What this is: Represents an editable text field, that when does not have focus displays its value as a label
class DankSensitiveText extends StatefulWidget {
  final String value;
  final SensitiveFieldType fieldType;
  final TextEditingController editingController;
  final Function(String) saveCallback;
  final String tooltipText;

  DankSensitiveText({
    Key key,
    String value,
    SensitiveFieldType fieldType,
    TextEditingController editingController,
    Function(String) saveCallback,
    String tooltipText,
  })  : this.value = value,
        this.fieldType = fieldType,
        this.editingController = editingController,
        this.saveCallback = saveCallback,
        this.tooltipText = tooltipText,
        super(key: key);

  @override
  _DankSensitiveTextState createState() => _DankSensitiveTextState(
        this.value,
        this.fieldType,
        this.editingController,
        this.saveCallback,
        this.tooltipText,
        this.value,
      );
}

class _DankSensitiveTextState extends State<DankSensitiveText> {
  TextEditingController editingController;
  Function(String) saveCallback;
  bool isEditingText = false;
  SensitiveFieldType fieldType;
  String value;
  String tooltipText;
  String originalValue;

  _DankSensitiveTextState(
    this.value,
    this.fieldType,
    this.editingController,
    this.saveCallback,
    this.tooltipText,
    this.originalValue,
  );

  @override
  void initState() {
    super.initState();
    editingController = TextEditingController(text: value);
  }

  @override
  void dispose() {
    super.dispose();
    editingController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If the parent propogated a change, reflect it in this component
    //<ParentBodyState> data = <ParentBodyState>.of(context);
    print(
        'To Do: Implement "didChangeDependencies" for DankSensitiveText widget.');

    if (!isEditingText) {
      switch (fieldType) {
        case SensitiveFieldType.UniqueId:
          //value = data.uniqueId;
          break;
        case SensitiveFieldType.Email:
          //value = data.email;
          break;
      }

      originalValue = value;
      editingController = TextEditingController(text: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEditingText)
      return Expanded(
        child: Container(
          height: 50.0,
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                editingCompleted();
              }
            },
            child: TextField(
              autofocus: true,
              controller: editingController,
              style: appInputFontStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
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
          ),
        ),
      );
    return DankTooltip(
      tooltipText: tooltipText,
      displayTooltip: false,
      child: InkWell(
        onTap: () {
          setState(() {
            isEditingText = true;
          });
        },
        child: Center(
          child: Container(
            child: Text(
              value,
              style: appValueLabelFontStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void editingCompleted() async {
    DankValidationDialogData data;
    bool safeToSave = false;
    String displayValue = this.originalValue;

    // Default the Readonly display to the new value (temporarily)
    setState(() {
      value = editingController.text;
    });

    if (this.originalValue != editingController.text) {
      data = getValidationData();

      safeToSave = await showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: DankValidationDialog(
                titleText: data.titleText,
                validationType: ValidationType.ButtonBasedValidation,
                messageText: data.messageText,
                beforeValue: this.originalValue,
                afterValue: this.value,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox(height: 20.0);
        },
      );

      // Save the change.  Hit the back-end API.
      if (safeToSave) {
        // Let the parent save this entity
        saveCallback(editingController.text);

        // Track the new value
        displayValue = editingController.text;
        originalValue = displayValue;
      }
    }

    // Set  the TextField Controller in accordance with the users decision
    editingController.text = displayValue;

    // Reset this widgets state to "read mode"
    setState(() {
      value = displayValue;
      isEditingText = false;
    });
  }

  DankValidationDialogData getValidationData() {
    DankValidationDialogData retval;

    switch (fieldType) {
      case SensitiveFieldType.UniqueId:
        retval = new DankValidationDialogData(
          titleText: 'Edit Unique ID',
          messageText:
              'You are editting the Unique ID.  This is sensitive data and rarely changes.  ' +
                  '\n\nPlease verify this change or undo it.',
        );
        break;
      case SensitiveFieldType.Email:
        retval = new DankValidationDialogData(
          titleText: 'Edit Email Address',
          messageText:
              'You are editting the Email address.  This is sensitive data and rarely changes.  ' +
                  '\n\nPlease verify this change or undo it.',
        );
        break;
    }

    return retval;
  }
}
