import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankDatePicker extends StatefulWidget {
  final DateTime defaultDate;
  final Function(DateTime) onDateChanged;

  DankDatePicker({
    @required DateTime defaultDate,
    @required Function(DateTime) onDateChanged,
  })  : this.defaultDate = defaultDate,
        this.onDateChanged = onDateChanged;

  @override
  _DankDatePickerState createState() => _DankDatePickerState();
}

class _DankDatePickerState extends State<DankDatePicker> {
  DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.defaultDate;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DankDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DankLabel(
          displayText: "${_selectedDate.toLocal()}".split(' ')[0],
          textStyle: appLabelFontStyle,
        ),
        DankIconButton(
          onPressed: () => _selectDate(context),
          iconData: Icons.calendar_today,
          iconSize: 30.0,
          color: appBaseWhiteTextColor,
          tooltipText: 'Click to select a date',
          margin: EdgeInsets.only(left: 10.0),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      fieldLabelText: 'Grow start date',
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      helpText: 'Select start date',
      cancelText: 'Cancel',
      confirmText: 'Save',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: appBaseColor,
            dialogBackgroundColor: appBackgroundColor,
            colorScheme: ColorScheme.dark(
              primary: appBaseColor,
              surface: appThirdColor,
            ),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 365))) &&
        day.isBefore(DateTime.now().add(Duration(days: 60))))) {
      return true;
    }

    return false;
  }
}
