import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankRadioButton extends StatefulWidget {
  final int id;
  final int currentIndex;
  final String displayText;
  final Function(int) onTapped;

  DankRadioButton({
    @required int id,
    @required int currentIndex,
    @required String displayText,
    @required Function(int) onTapped,
  })  : this.id = id,
        this.currentIndex = currentIndex,
        this.displayText = displayText,
        this.onTapped = onTapped;

  @override
  _DankRadioButtonState createState() => _DankRadioButtonState();
}

class _DankRadioButtonState extends State<DankRadioButton> {
  bool _isRemoveHovered = false;

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
  void didUpdateWidget(DankRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    bool isSelect = widget.currentIndex == widget.id;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.currentIndex != widget.id) {
              widget.onTapped(widget.id);
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (pointerEvent) {
              setState(() {
                _isRemoveHovered = true;
              });
            },
            onExit: (pointerEvent) {
              setState(() {
                _isRemoveHovered = false;
              });
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: appBorderUnselectedColor,
                  width: 2,
                ),
                boxShadow: [
                  if (isSelect)
                    BoxShadow(
                      color: appBaseColor.withOpacity(0.1),
                      blurRadius: 15.0,
                      spreadRadius: 7.0,
                    ),
                ],
              ),
              child: Container(
                height: 12.0,
                width: 12.0,
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: getColor(),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        DankLabel(
          displayText: widget.displayText,
          textStyle: appLabelFontStyle.copyWith(
            fontSize: 14.0,
            color: (widget.currentIndex == widget.id)
                ? appBaseWhiteTextColor
                : appBaseWhiteTextColor.withOpacity(0.6),
          ),
          padding: EdgeInsets.only(left: 8.0),
        ),
      ],
    );
  }

  Color getColor() {
    Color retval = Colors.transparent;

    if (widget.currentIndex == widget.id) {
      retval = appBaseColor;
    } else if (_isRemoveHovered) {
      retval = appBaseColor.withOpacity(0.4);
    }

    return retval;
  }
}
