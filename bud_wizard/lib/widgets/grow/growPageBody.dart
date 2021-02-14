import 'dart:async';
import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/widgets/grow/add/addGrow.dart';
import 'package:bud_wizard/widgets/grow/growActivity.dart';
import 'package:bud_wizard/widgets/grow/growDetail.dart';
import 'package:bud_wizard/widgets/grow/growSelector.dart';
import 'package:bud_wizard/widgets/grow/myFirstGrow.dart';
import 'package:bud_wizard/widgets/plant/add/addPlant.dart';
import 'package:bud_wizard/widgets/plant/plantDetail.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/dankSizeTransition.dart';
import 'package:bud_wizard/widgets/shared%20widgets/animations/fadeIn.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-icon-button.dart';
import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class GrowPageBody extends StatefulWidget {
  final Future<List<Grow>> _grows;
  final Grow _currentGrow;
  final Plant _currentPlant;
  final PlantOperation _currentPlantOp;
  final GrowOperation _currentGrowOp;

  GrowPageBody({
    @required Future<List<Grow>> grows,
    @required Grow currentGrow,
    @required Plant currentPlant,
    @required PlantOperation currentPlantOp,
    @required GrowOperation currentGrowOp,
  })  : this._grows = grows,
        this._currentGrow = currentGrow,
        this._currentPlant = currentPlant,
        this._currentPlantOp = currentPlantOp,
        this._currentGrowOp = currentGrowOp;

  @override
  _GrowPageBodyState createState() => _GrowPageBodyState();
}

class _GrowPageBodyState extends State<GrowPageBody> {
  // Dynamic display of Grow Selector
  bool _growSelectorVisibility = false;
  bool _isGrowSelectorVisible = true;
  Timer _growSelectorTimer;

  // Dynamic display of Grow Activity
  bool _growActivityVisibility = false;
  bool _isGrowActivityVisible = true;
  Timer _growActivityTimer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget._currentGrowOp != GrowOperation.AddGrow)
            FutureBuilder<List<Grow>>(
              future: widget._grows,
              builder: (context, snapshot) {
                Grow currentGrow;
                Widget retval = SizedBox.shrink();

                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    if (widget._currentGrow == null) {
                      currentGrow = snapshot.data[0];
                    } else {
                      currentGrow = widget._currentGrow;
                    }

                    retval = DankSizeTransition(
                      isVisible: _isGrowSelectorVisible,
                      child: GrowSelector(
                        grows: snapshot.data,
                        currentGrow: currentGrow,
                        currentPlant: widget._currentPlant,
                        hoverBegins: _enableGrowSelectorCollapseButtons,
                        hoverEnds: _disableGrowSelectorCollapseButtons,
                      ),
                    );
                  }
                }

                return retval;
              },
            ),
          Expanded(
            child: Stack(
              children: [
                _getBody(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildExpandGrowMenuToggle(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildExpandGrowActivityToggle(),
                ),
              ],
            ),
          ),
          (widget._currentPlant != null &&
                  widget._currentPlantOp != PlantOperation.Statistics)
              ? DankSizeTransition(
                  isVisible: _isGrowActivityVisible,
                  child: GrowActivity(
                    hoverBegins: _enableGrowActivityCollapseButtons,
                    hoverEnds: _disableGrowActivityCollapseButtons,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildExpandGrowMenuToggle() {
    return FadeIn(
      duration: 500,
      child: DankIconButton(
        iconData:
            (_isGrowSelectorVisible) ? Icons.chevron_left : Icons.chevron_right,
        iconSize: 45,
        tooltipText: (_isGrowSelectorVisible)
            ? 'Collapse grow menu'
            : 'Expand grow menu',
        buttonType: DankButtonType.Outline,
        color: appBaseWhiteTextColor,
        hoverColor: Colors.black,
        outlineColor: Colors.transparent,
        outlineThickness: 3.5,
        onPressed: _toggleGrowSelectorVisibility,
        displayTooltip: true,
        margin: EdgeInsets.only(
          left: 5.0,
          bottom: 5.0,
        ),
        onHover: _enableGrowSelectorCollapseButtons,
        onLostHover: _disableGrowSelectorCollapseButtons,
      ),
      isVisible: _growSelectorVisibility,
    );
  }

  Widget _buildExpandGrowActivityToggle() {
    return FadeIn(
      duration: 500,
      child: DankIconButton(
        iconData:
            (_isGrowActivityVisible) ? Icons.chevron_right : Icons.chevron_left,
        iconSize: 45,
        tooltipText: (_isGrowActivityVisible)
            ? 'Collapse grow activity'
            : 'Expand grow activity',
        buttonType: DankButtonType.Outline,
        color: appBaseWhiteTextColor,
        hoverColor: Colors.black,
        outlineColor: Colors.transparent,
        outlineThickness: 3.5,
        onPressed: _toggleGrowActivityVisibility,
        displayTooltip: true,
        margin: EdgeInsets.only(
          right: 5.0,
          bottom: 5.0,
        ),
        onHover: _enableGrowActivityCollapseButtons,
        onLostHover: _disableGrowActivityCollapseButtons,
        tooltipDirection: TooltipDirection.left,
      ),
      isVisible: _growActivityVisibility,
    );
  }

  Widget _getBody() {
    Widget retval = SizedBox.shrink();

    if (widget._currentGrowOp == GrowOperation.AddGrow) {
      retval = AddGrow();
    } else if (widget._currentPlantOp == PlantOperation.AddPlant) {
      retval = AddPlant(grow: widget._currentGrow);
    } else if (widget._currentPlant != null) {
      retval = PlantDetail(
        plant: widget._currentPlant,
        operation: widget._currentPlantOp,
      );
    } else if (widget._currentGrow != null) {
      retval = GrowDetail(
        grows: widget._grows,
        currentGrow: widget._currentGrow,
      );
    } else {
      // Base states.  Either this User only has created a Grow
      // or they don't even have that.  Force it upon them!
      if (widget._currentGrow == null) {
        retval = MyFirstGrow();
      } else {
        print(
            'GrowPageBody._getBody() - ERROR! GrowPage has no idea wtf to render for it\'s body.');
      }
    }

    return retval;
  }

//#region Grow Activity collapse/display handlers

  void _toggleGrowActivityVisibility() {
    setState(() {
      _isGrowActivityVisible = !_isGrowActivityVisible;
    });
  }

  void _hideGrowActivityCollapseButtons() {
    setState(() {
      _growActivityVisibility = false;
      _growActivityTimer.cancel();
    });
  }

  void _enableGrowActivityCollapseButtons() {
    setState(() {
      _growActivityVisibility = true;

      if (_growActivityTimer != null && _growActivityTimer.isActive) {
        _growActivityTimer.cancel();
      }
    });
  }

  void _disableGrowActivityCollapseButtons() {
    setState(() {
      _growActivityTimer = Timer(
        Duration(milliseconds: 1000),
        _hideGrowActivityCollapseButtons,
      );
    });
  }

  //#endregion
  //#region Grow Selector collapse/display handlers
  void _toggleGrowSelectorVisibility() {
    setState(() {
      _isGrowSelectorVisible = !_isGrowSelectorVisible;
    });
  }

  void _hideGrowSelectorCollapseButtons() {
    setState(() {
      _growSelectorVisibility = false;
      _growSelectorTimer.cancel();
    });
  }

  void _enableGrowSelectorCollapseButtons() {
    setState(() {
      _growSelectorVisibility = true;

      if (_growSelectorTimer != null && _growSelectorTimer.isActive) {
        _growSelectorTimer.cancel();
      }
    });
  }

  void _disableGrowSelectorCollapseButtons() {
    setState(() {
      _growSelectorTimer = Timer(
        Duration(milliseconds: 1000),
        _hideGrowSelectorCollapseButtons,
      );
    });
  }

  //#endregion
}
