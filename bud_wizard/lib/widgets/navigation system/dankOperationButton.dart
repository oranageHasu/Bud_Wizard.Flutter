import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/widgets/navigation%20system/dankOperationPanel.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:flutter/material.dart';

class DankOperationButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String tooltipText;
  final IconData icon;
  final bool isSelected;
  final Screen screen;

  DankOperationButton({
    Key key,
    @required String tooltipText,
    @required IconData icon,
    VoidCallback onPressed,
    bool isSelected = false,
    Screen screen,
  })  : this.onPressed = onPressed,
        this.tooltipText = tooltipText,
        this.icon = icon,
        this.isSelected = isSelected,
        this.screen = screen,
        super(key: key);

  @override
  _DankOperationButtonState createState() => _DankOperationButtonState();
}

class _DankOperationButtonState extends State<DankOperationButton> {
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
  void didUpdateWidget(DankOperationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            height: (_isHovered && !widget.isSelected) ? 25.0 : 60.0,
            width: 4.0,
            decoration: BoxDecoration(
              color: (widget.isSelected || _isHovered)
                  ? appBaseWhiteTextColor
                  : Colors.transparent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 70.0,
          width: 10.0,
        ),
        DankIconButton(
          iconData: widget.icon,
          tooltipText: widget.tooltipText,
          iconSize: 35.0,
          buttonType: DankButtonType.Flat,
          onPressed: () {
            DankOperationPanel.of(context).navigateTo(widget.screen);
          },
          onHover: onHover,
          onLostHover: onLostHover,
          isSelected: widget.isSelected,
          enableAnimation: true,
        ),
        SizedBox(
          height: 70.0,
          width: 10.0,
        ),
      ],
    );
  }

  void onHover() {
    setState(() {
      _isHovered = true;
    });
  }

  void onLostHover() {
    setState(() {
      _isHovered = false;
    });
  }
}
