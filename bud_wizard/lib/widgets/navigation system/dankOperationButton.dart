import 'package:bud_wizard/classes/app-theme.dart';
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
    bool isSelected,
    Screen screen,
  })  : this.onPressed = onPressed,
        this.tooltipText = tooltipText,
        this.icon = icon,
        this.isSelected = isSelected,
        this.screen = screen,
        super(key: key);

  @override
  _DankOperationButtonState createState() => _DankOperationButtonState(
        this.onPressed,
        this.tooltipText,
        this.icon,
        this.isSelected,
        this.screen,
      );
}

class _DankOperationButtonState extends State<DankOperationButton> {
  VoidCallback onPressed;
  String tooltipText;
  IconData icon;
  bool isHovered = false;
  bool isSelected = false;
  Screen screen;

  _DankOperationButtonState(
    this.onPressed,
    this.tooltipText,
    this.icon,
    this.isSelected,
    this.screen,
  );

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

    isSelected = widget.isSelected;
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
            height: (isHovered && !isSelected) ? 25.0 : 60.0,
            width: 4.0,
            decoration: BoxDecoration(
              color: (isSelected || isHovered)
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
          iconData: icon,
          tooltipText: tooltipText,
          iconSize: 35.0,
          buttonType: DankButtonType.Flat,
          onPressed: () {
            DankOperationPanel.of(context).navigateTo(screen);
          },
          onHover: onHover,
          onLostHover: onLostHover,
          isSelected: isSelected,
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
      isHovered = true;
    });
  }

  void onLostHover() {
    setState(() {
      isHovered = false;
    });
  }
}
