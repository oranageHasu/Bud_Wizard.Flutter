import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankStepperStep extends StatefulWidget {
  final int index;
  final DankStepItem item;
  final bool isLast;
  final bool isSelected;
  final Color color;
  final Color iconColor;

  DankStepperStep({
    @required int index,
    @required DankStepItem item,
    @required bool isLast,
    @required bool isSelected,
    Color color = appPrimaryColor,
    Color iconColor = appBaseWhiteTextColor,
  })  : this.index = index,
        this.item = item,
        this.isLast = isLast,
        this.isSelected = isSelected,
        this.color = color,
        this.iconColor = iconColor;

  @override
  _DankStepperStepState createState() => _DankStepperStepState();
}

class _DankStepperStepState extends State<DankStepperStep> {
  bool _isHovered = false;

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
  void didUpdateWidget(DankStepperStep oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            DankStepper.of(context).setCurrentIndex(widget.index);
          },
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
            child: Row(
              children: [
                Container(
                  width: 65.0,
                  height: 65.0,
                  margin: EdgeInsets.only(
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: widget.color,
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (widget.isSelected || _isHovered)
                            ? widget.color.withOpacity(0.5)
                            : Colors.transparent,
                        blurRadius: 35.0,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.item.icon,
                    color: (widget.isSelected || _isHovered)
                        ? widget.iconColor
                        : Colors.grey.shade400,
                    size: 50.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DankLabel(
                      displayText: widget.item.title,
                      textStyle: appHeaderFontStyle.copyWith(
                        fontSize: 20.0,
                        color: widget.color,
                      ),
                    ),
                    DankLabel(
                      displayText: widget.item.subtitle,
                      textStyle: appLabelFontStyle.copyWith(
                        fontSize: 12.0,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (!widget.isLast)
          Container(
            margin: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: CustomPaint(
              size: Size(50, 50),
              painter: MyPainter(),
            ),
          ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the horizontal arrow line
    Offset p1 = Offset(0, 25);
    Offset p2 = Offset(50, 25);
    Paint paint = Paint()
      ..color = appUnselectedColor
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);

    // Draw the bottom arrow line
    p1 = Offset(35, 35);
    p2 = Offset(50, 25);
    paint = Paint()
      ..color = appUnselectedColor
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);

    // Draw the top arrow line
    p1 = Offset(35, 15);
    p2 = Offset(50, 25);
    paint = Paint()
      ..color = appUnselectedColor
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
