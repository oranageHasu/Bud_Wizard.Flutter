import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicTooltip.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DankChip extends StatefulWidget {
  final DankLabel label;
  final VoidCallback onTapped;

  DankChip({
    @required DankLabel label,
    @required VoidCallback onTapped,
  })  : this.label = label,
        this.onTapped = onTapped;

  @override
  _DankChipState createState() => _DankChipState();
}

class _DankChipState extends State<DankChip> {
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
  void didUpdateWidget(DankChip oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: appDarkContentBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          widget.label,
          GestureDetector(
            onTap: widget.onTapped,
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
                margin: EdgeInsets.only(left: 7.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (_isRemoveHovered)
                        ? appErrorColor
                        : Colors.red.withOpacity(0.5),
                    width: 3.0,
                  ),
                  shape: BoxShape.circle,
                ),
                child: DankBasicTooltip(
                  tooltipText: 'Click to remove',
                  child: Icon(
                    CommunityMaterialIcons.close_thick,
                    color: (_isRemoveHovered)
                        ? appErrorColor
                        : Colors.red.withOpacity(0.5),
                    size: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
