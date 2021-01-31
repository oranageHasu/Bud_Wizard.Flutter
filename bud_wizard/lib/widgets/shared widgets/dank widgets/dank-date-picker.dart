import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankDatePicker extends StatefulWidget {
  final String label;
  final DateTime defaultDate;
  final Function(DateTime) onDateChanged;

  DankDatePicker({
    @required String label,
    @required DateTime defaultDate,
    @required Function(DateTime) onDateChanged,
  })  : this.label = label,
        this.defaultDate = defaultDate,
        this.onDateChanged = onDateChanged;

  @override
  _DankDatePickerState createState() => _DankDatePickerState();
}

class _DankDatePickerState extends State<DankDatePicker> {
  DateTime _selectedDate;
  bool _isHovered = false;

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
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 13.5, 10.0, 13.5),
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DankLabel(
            displayText: widget.label,
            textStyle: appLabelFontStyle,
            padding: EdgeInsets.only(right: 10.0),
          ),
          DankLabel(
            displayText: "${_selectedDate.toLocal()}".split(' ')[0],
            textStyle: appLabelFontStyle,
          ),
          GestureDetector(
            onTap: _selectDate,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (pointerEvent) {
                setState(() {
                  _isHovered = true;
                });
              },
              onExit: (pointerEvent) {
                setState(() {
                  _isHovered = false;
                });
              },
              child: Container(
                width: 45.0,
                height: 45.0,
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: appBaseColor,
                    width: 2.0,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_isHovered)
                          ? appBaseColor.withOpacity(0.3)
                          : Colors.transparent,
                      blurRadius: 25.0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: (_isHovered)
                      ? appBaseWhiteTextColor
                      : Colors.grey.shade400,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate() async {
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
