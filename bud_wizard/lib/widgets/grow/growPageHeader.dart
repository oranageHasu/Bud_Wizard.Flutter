import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/services/loggerService.dart';
import 'package:bud_wizard/widgets/grow/growSearch.dart';
import 'package:bud_wizard/widgets/plant/menu/plantMenu.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/user/userIconMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GrowPageHeader extends StatefulWidget {
  final bool isPlantSelected;
  final bool isNotificationDisplayed;
  final Grow currentGrow;
  final PlantOperation currentPlantOp;

  GrowPageHeader({
    @required Grow currentGrow,
    @required PlantOperation currentPlantOp,
    bool isPlantSelected = false,
    bool isNotificationDisplayed = false,
  })  : this.currentGrow = currentGrow,
        this.currentPlantOp = currentPlantOp,
        this.isPlantSelected = isPlantSelected,
        this.isNotificationDisplayed = isNotificationDisplayed;

  @override
  _GrowPageHeaderState createState() => _GrowPageHeaderState(
        isNotificationDisplayed,
      );
}

class _GrowPageHeaderState extends State<GrowPageHeader> {
  bool isNotificationDisplayed;

  _GrowPageHeaderState(
    this.isNotificationDisplayed,
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
  void didUpdateWidget(GrowPageHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isNotificationDisplayed) notification(),
        header(),
      ],
    );
  }

  Widget notification() {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appBaseColor,
            Color.fromRGBO(71, 184, 196, 1.0),
            Color.fromRGBO(71, 165, 196, 1.0),
          ],
          stops: [
            0,
            0.7,
            0.9,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DankLabel(
                  displayText: 'Want to increase your yields?  Get a',
                  textStyle: appLabelFontStyle.copyWith(
                    fontSize: 14.0,
                    color: appBaseBlackTextColor,
                  ),
                ),
                DankLabel(
                  displayText: ' FREE ',
                  textStyle: appLabelFontStyle.copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: appBaseBlackTextColor,
                  ),
                ),
                DankLabel(
                  displayText: 'year of Bud Wizard Pro.',
                  textStyle: appLabelFontStyle.copyWith(
                    fontSize: 14.0,
                    color: appBaseBlackTextColor,
                  ),
                  padding: EdgeInsets.only(
                    right: 20.0,
                  ),
                ),
                DankButton(
                  buttonText: 'Learn More',
                  onPressed: learnMore,
                  borderColor: appBaseWhiteTextColor.withOpacity(0.3),
                  borderRadius: 5,
                  textPadding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  invertHoverColor: true,
                  hoverColor: Colors.white.withOpacity(0.8),
                  textColor: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          ),
          DankIconButton(
            iconData: Icons.clear,
            displayTooltip: false,
            tooltipText: '',
            iconSize: 20.0,
            onPressed: dismissNotification,
            buttonType: DankButtonType.Outline,
            outlineColor: Colors.transparent,
            showClickInteraction: false,
          ),
        ],
      ),
    );
  }

  Widget header() {
    double borderRadius = (isNotificationDisplayed) ? 0.0 : 10.0;

    return Container(
      decoration: BoxDecoration(
        color: (currentTheme.currentTheme() == ThemeMode.dark)
            ? appDarkTertiaryColor
            : appLightTertiaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GrowSearch(),
            (widget.isPlantSelected)
                ? PlantMenu(currentOperation: widget.currentPlantOp)
                : Expanded(
                    child: Container(
                      color: (currentTheme.isDarkTheme())
                          ? appDarkTertiaryColor
                          : appLightTertiaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: DankLabel(
                              displayText: (widget.currentGrow != null)
                                  ? widget.currentGrow.name
                                  : '',
                              textStyle: appLabelFontStyle,
                              textAlign: TextAlign.center,
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 2.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                          ),
                          UserIconMenu(),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void dismissNotification() {
    setState(() {
      isNotificationDisplayed = false;
    });
  }

  void learnMore() {
    log('To Do: Learn More clicked.');
  }
}
