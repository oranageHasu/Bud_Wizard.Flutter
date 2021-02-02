import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-stepper-step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankStepItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget content;

  DankStepItem({
    @required String title,
    @required String subtitle,
    @required IconData icon,
    @required Widget content,
  })  : this.title = title,
        this.subtitle = subtitle,
        this.icon = icon,
        this.content = content;
}

class DankStepper extends StatefulWidget {
  final List<DankStepItem> steps;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onFinished;

  DankStepper({
    @required List<DankStepItem> steps,
    @required selectedColor,
    @required unselectedColor,
    @required VoidCallback onFinished,
  })  : this.steps = steps,
        this.selectedColor = selectedColor,
        this.unselectedColor = unselectedColor,
        this.onFinished = onFinished;

  static DankStepperState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DankStepperWidget>()
        .stepperData;
  }

  @override
  State<StatefulWidget> createState() => DankStepperState();
}

class DankStepperState extends State<DankStepper> {
  int _currentIndex = 0;
  String _forwardActionText = 'Next';
  bool _isBackVisible = false;

  @override
  void initState() {
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
  void didUpdateWidget(DankStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void setCurrentIndex(int index) {
    clickAction(index);
  }

  @override
  Widget build(BuildContext context) {
    return DankStepperWidget(
      stepperData: this,
      child: Container(
        width: 1160.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < widget.steps.length; i++)
                  DankStepperStep(
                    index: i,
                    item: widget.steps[i],
                    isLast: i == widget.steps.length - 1,
                    isSelected: _currentIndex == i,
                    iconColor: appBaseWhiteTextColor.withOpacity(0.8),
                  ),
              ],
            ),
            Container(
              height: 385.0,
              constraints: (MediaQuery.of(context).size.height > 720)
                  ? BoxConstraints(minHeight: 385.0)
                  : null,
              margin: EdgeInsets.only(
                top: 35.0,
                bottom: 25.0,
                left: 40.0,
                right: 40.0,
              ),
              child: widget.steps[_currentIndex].content,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DankButton(
                  buttonType: DankButtonType.Flat,
                  buttonText: 'Cancel',
                  borderRadius: 5.0,
                  padding: EdgeInsets.all(15.0),
                  textStyle: appLabelFontStyle.copyWith(
                    color: appBaseColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: cancelPressed,
                  backgroundColor: Colors.black.withOpacity(0.1),
                ),
                Visibility(
                  child: DankButton(
                    buttonText: 'Back',
                    borderRadius: 5.0,
                    margin: EdgeInsets.only(left: 10.0),
                    padding: EdgeInsets.all(15.0),
                    textStyle: appLabelFontStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: backwardAction,
                  ),
                  visible: _isBackVisible,
                ),
                DankButton(
                  buttonType: DankButtonType.Flat,
                  buttonText: _forwardActionText,
                  borderRadius: 5.0,
                  margin: EdgeInsets.only(left: 10.0),
                  padding: EdgeInsets.all(15.0),
                  textStyle: appLabelFontStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: forwardAction,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void cancelPressed() {
    print('To Do: Cancel creating Grow');
  }

  void clickAction(int index) {
    setState(() {
      _currentIndex = index;

      if (_currentIndex == widget.steps.length - 1) {
        _forwardActionText = 'Finished';
      } else {
        _forwardActionText = 'Next';
      }

      _isBackVisible = _currentIndex != 0;
    });
  }

  void backwardAction() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _forwardActionText = 'Next';
        _isBackVisible = _currentIndex != 0;
      });
    }
  }

  void forwardAction() {
    if (_currentIndex == widget.steps.length - 1) {
      widget.onFinished();
    } else {
      setState(() {
        _currentIndex++;
        _isBackVisible = true;

        if (_currentIndex == widget.steps.length - 1) {
          _forwardActionText = 'Finished';
        } else {
          _forwardActionText = 'Next';
        }
      });
    }
  }
}

class DankStepperWidget extends InheritedWidget {
  final DankStepperState stepperData;

  DankStepperWidget({
    Key key,
    @required Widget child,
    @required this.stepperData,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DankStepperWidget oldWidget) {
    return true;
  }
}
