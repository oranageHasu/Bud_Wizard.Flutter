import 'dart:async';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant%20system/plant.dart';
import 'package:bud_wizard/models/plant%20system/plantImage.dart';
import 'package:bud_wizard/services/api%20services/apiPlantImages.dart';
import 'package:bud_wizard/widgets/plant/images/plantImageContainer.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum SlideDirection {
  Left,
  Right,
}

class PlantImageSelector extends StatefulWidget {
  final Guid userId;
  final Plant plant;
  final int growWeek;

  PlantImageSelector({
    @required Guid userId,
    @required Plant plant,
    @required int growWeek,
  })  : this.userId = userId,
        this.plant = plant,
        this.growWeek = growWeek;

  @override
  _PlantImageSelectorState createState() => _PlantImageSelectorState();
}

class _PlantImageSelectorState extends State<PlantImageSelector> {
  bool _isHovered = false;
  bool _scrollButtonsVisible = false;
  ScrollController _plantImageController = ScrollController();
  Future<List<PlantImage>> _plantImages;
  List<PlantImage> _currentData;
  FutureBuilder<List<PlantImage>> _plantImageSelectorBody;

  // Timer used to do scroll button effects
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _refreshPlantImages();
  }

  @override
  void didUpdateWidget(PlantImageSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.userId != oldWidget.userId ||
        widget.plant.plantId != oldWidget.plant.plantId ||
        widget.growWeek != oldWidget.growWeek) {
      _refreshPlantImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (value) {
        setState(() {
          _isHovered = true;
        });
        _timer = Timer(
          Duration(milliseconds: 100),
          _showScrollButtons,
        );
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
            child: _buildBody(),
          ),
          if (_isHovered)
            Positioned.fill(
              child: Row(
                children: [
                  _scrollButton(SlideDirection.Left),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  _scrollButton(SlideDirection.Right),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    Widget retval;

    if (_plantImageSelectorBody == null) {
      _plantImageSelectorBody = FutureBuilder<List<PlantImage>>(
        future: _plantImages,
        builder: (context, snapshot) {
          Widget retval = Center(
            child: FadeIn(
              duration: 800,
              isVisible: true,
              child: SpinKitWave(
                color: appBaseColor,
                size: 30.0,
              ),
            ),
          );

          if (snapshot.hasData && snapshot.data.length > 0) {
            if (snapshot.data != _currentData) {
              retval = _buildPlantImages(snapshot.data);
            }
          } else if (snapshot.hasData) {
            if (snapshot.data != _currentData) {
              retval = Center(
                child: FadeIn(
                  duration: 600,
                  isVisible: true,
                  child: DankLabel(
                    displayText: 'Click to add a new plant image',
                    textStyle: appLabelFontStyle.copyWith(
                      color: appBaseWhiteTextColor,
                    ),
                  ),
                ),
              );
            }
          }

          return retval;
        },
      );
    }

    retval = _plantImageSelectorBody;

    return retval;
  }

  Widget _buildPlantImages(List<PlantImage> plantImages) {
    _currentData = plantImages;

    return FadeIn(
      duration: 600,
      isVisible: true,
      child: ListView(
        controller: _plantImageController,
        scrollDirection: Axis.horizontal,
        children: [
          for (PlantImage image in plantImages)
            PlantImageContainer(
              base64Image: image.base64Image,
            ),
        ],
      ),
    );
  }

  Widget _scrollButton(SlideDirection direction) {
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
          color: (currentTheme.isDarkTheme())
              ? appBaseWhiteTextColor
              : appBaseBlackTextColor,
          hoverColor: Colors.black,
          outlineColor: Colors.transparent,
          outlineThickness: 3.5,
          onPressed:
              (direction == SlideDirection.Left) ? _slideLeft : _slideRight,
          displayTooltip: false,
        ),
      ),
      isVisible: _scrollButtonsVisible,
    );
  }

  void _refreshPlantImages() {
    _plantImageSelectorBody = null;

    _plantImages = getPlantImages(
      userId: widget.userId,
      plantId: widget.plant.plantId,
      growWeek: widget.growWeek,
    );
  }

  void _showScrollButtons() {
    // Stop the timer
    _timer.cancel();

    // Enable the scroll button visibility
    setState(() {
      _scrollButtonsVisible = true;
    });
  }

  void _slideLeft() {
    _slide(SlideDirection.Left);
  }

  void _slideRight() {
    _slide(SlideDirection.Right);
  }

  void _slide(SlideDirection direction) {
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
