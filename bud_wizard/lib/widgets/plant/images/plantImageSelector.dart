import 'dart:async';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageContainer.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum SlideDirection {
  Left,
  Right,
}

class PlantImageSelector extends StatefulWidget {
  final Plant plant;

  PlantImageSelector({
    Plant plant,
  }) : this.plant = plant;

  @override
  _PlantImageSelectorState createState() => _PlantImageSelectorState(
        this.plant,
      );
}

class _PlantImageSelectorState extends State<PlantImageSelector> {
  Plant plant;
  bool _isHovered = false;
  bool _scrollButtonsVisible = false;
  ScrollController _plantImageController = new ScrollController();

  // Timer used to do scroll button effects
  Timer _timer;

  _PlantImageSelectorState(
    this.plant,
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
  void didUpdateWidget(PlantImageSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.plant = widget.plant;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (value) {
        setState(() {
          _isHovered = true;
        });
        _timer = new Timer(Duration(milliseconds: 100), showScrollButtons);
      },
      onExit: (value) {
        setState(() {
          _isHovered = false;
          _scrollButtonsVisible = false;
        });

        if (_timer != null && _timer.isActive) {
          _timer.cancel();
        }
      },
      child: Stack(
        children: [
          Container(
            height: 150.0,
            padding: EdgeInsets.only(
              left: 2.0,
              right: 2.0,
              top: 5.0,
            ),
            child: ListView(
              controller: _plantImageController,
              scrollDirection: Axis.horizontal,
              children: [
                PlantImageContainer(imgPath: 'grow/img1.jpg'),
                PlantImageContainer(imgPath: 'grow/img2.jpg'),
                PlantImageContainer(imgPath: 'grow/img3.jpg'),
                PlantImageContainer(imgPath: 'grow/img11.jpg'),
                PlantImageContainer(imgPath: 'grow/img12.jpg'),
                PlantImageContainer(imgPath: 'grow/img4.jpg'),
                PlantImageContainer(imgPath: 'grow/img5.jpg'),
                PlantImageContainer(imgPath: 'grow/img6.jpg'),
                PlantImageContainer(imgPath: 'grow/img7.jpg'),
              ],
            ),
          ),
          if (_isHovered)
            Positioned.fill(
              child: Row(
                children: [
                  scrollButton(SlideDirection.Left),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  scrollButton(SlideDirection.Right),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget scrollButton(SlideDirection direction) {
    return FadeIn(
      500,
      Container(
        margin: (direction == SlideDirection.Left)
            ? EdgeInsets.only(left: 20.0, top: 10.0)
            : EdgeInsets.only(right: 20.0, top: 10.0),
        child: DankIconButton(
          iconData: (direction == SlideDirection.Left)
              ? Icons.chevron_left
              : Icons.chevron_right,
          iconSize: 45,
          tooltipText: '',
          buttonType: DankButtonType.Outline,
          color: appBaseWhiteTextColor,
          hoverColor: Colors.black,
          outlineColor: Colors.transparent,
          outlineThickness: 3.5,
          onPressed:
              (direction == SlideDirection.Left) ? slideLeft : slideRight,
          displayTooltip: false,
        ),
      ),
      _scrollButtonsVisible,
    );
  }

  void showScrollButtons() {
    // Stop the timer
    _timer.cancel();

    // Enable the scroll button visibility
    setState(() {
      _scrollButtonsVisible = true;
    });
  }

  void slideLeft() {
    slide(SlideDirection.Left);
  }

  void slideRight() {
    slide(SlideDirection.Right);
  }

  void slide(SlideDirection direction) {
    double newOffset = 0.0;

    if (direction == SlideDirection.Left) {
      newOffset = _plantImageController.position.pixels - 250.0;
    } else {
      newOffset = _plantImageController.position.pixels + 250.0;
    }

    _plantImageController.animateTo(
      newOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
