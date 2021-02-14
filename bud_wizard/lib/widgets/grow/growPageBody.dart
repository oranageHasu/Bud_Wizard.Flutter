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

  // Timer used to do collapse button effects
  Timer _timer;

  // Dynamic display of Grow Activity
  bool _growActivityVisibility = false;
  bool _isGrowActivityVisible = true;

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
                        hoverBegins: _enableCollapseButtons,
                        hoverEnds: _disableCollapseButtons,
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
              ? GrowActivity()
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
        onPressed: _toggleSelectorVisibility,
        displayTooltip: true,
        margin: EdgeInsets.only(
          left: 5.0,
          bottom: 5.0,
        ),
        onHover: _enableCollapseButtons,
        onLostHover: _disableCollapseButtons,
      ),
      isVisible: _growSelectorVisibility,
    );
  }

  Widget _buildExpandGrowActivityToggle() {
    return FadeIn(
      duration: 500,
      child: DankIconButton(
        iconData:
            (_isGrowSelectorVisible) ? Icons.chevron_right : Icons.chevron_left,
        iconSize: 45,
        tooltipText: (_isGrowActivityVisible)
            ? 'Collapse grow activity'
            : 'Expand grow activity',
        buttonType: DankButtonType.Outline,
        color: appBaseWhiteTextColor,
        hoverColor: Colors.black,
        outlineColor: Colors.transparent,
        outlineThickness: 3.5,
        onPressed: _toggleSelectorVisibility,
        displayTooltip: true,
        margin: EdgeInsets.only(
          right: 5.0,
          bottom: 5.0,
        ),
        onHover: _enableCollapseButtons,
        onLostHover: _disableCollapseButtons,
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

  void _toggleSelectorVisibility() {
    setState(() {
      _isGrowSelectorVisible = !_isGrowSelectorVisible;
    });
  }

  void _hideCollapseButtons() {
    setState(() {
      _growSelectorVisibility = false;
      _timer.cancel();
    });
  }

  void _enableCollapseButtons() {
    setState(() {
      _growSelectorVisibility = true;

      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }
    });
  }

  void _disableCollapseButtons() {
    setState(() {
      _timer = Timer(
        Duration(milliseconds: 1000),
        _hideCollapseButtons,
      );
    });
  }
}
