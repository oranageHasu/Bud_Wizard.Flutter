import 'package:bud_wizard/models/grow.dart';
import 'package:bud_wizard/widgets/grow/growCard.dart';
import 'package:flutter/material.dart';

class GrowSelector extends StatelessWidget {
  final List<Grow> grows;
  final Grow currentGrow;

  GrowSelector({
    @required List<Grow> grows,
    @required Grow currentGrow,
  })  : this.grows = grows,
        this.currentGrow = currentGrow;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: 300.0,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              for (Grow grow in grows)
                GrowCard(
                  grow: grow,
                  tooltipText: 'Click to see this Grow',
                  isSelected: currentGrow == grow,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
