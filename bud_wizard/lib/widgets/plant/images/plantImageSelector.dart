import 'dart:async';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageContainer.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
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
  _PlantImageSelectorState createState() => _PlantImageSelectorState();
}

class _PlantImageSelectorState extends State<PlantImageSelector> {
  bool _isHovered = false;
  bool _scrollButtonsVisible = false;
  ScrollController _plantImageController = new ScrollController();

  // Timer used to do scroll button effects
  Timer _timer;

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
            child: (widget.plant.imagePath.isEmpty)
                ? ListView(
                    controller: _plantImageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                        PlantImageContainer(imgPath: 'assets/grow/img1.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img2.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img3.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img11.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img12.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img4.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img5.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img6.jpg'),
                        PlantImageContainer(imgPath: 'assets/grow/img7.jpg'),
                      ])
                : Center(
                    child: DankLabel(
                        displayText: 'No Images',
                        textStyle: appLabelFontStyle.copyWith(
                          color: appBaseWhiteTextColor,
                        )),
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
      duration: 500,
      child: Container(
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
      isVisible: _scrollButtonsVisible,
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
