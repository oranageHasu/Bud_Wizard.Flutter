import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)
class DankPieChart extends StatefulWidget {
  final Color chartBackgroundColor;

  DankPieChart({
    Color chartBackgroundColor = appBackgroundColor,
  }) : this.chartBackgroundColor = chartBackgroundColor;

  @override
  _DankPieChartState createState() => _DankPieChartState();
}

class _DankPieChartState extends State<DankPieChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: widget.chartBackgroundColor,
      ),
      child: AspectRatio(
        aspectRatio: 2.5,
        child: PieChart(
          PieChartData(
              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                setState(() {
                  if (pieTouchResponse.touchInput is FlLongPressEnd ||
                      pieTouchResponse.touchInput is FlPanEnd) {
                    touchedIndex = -1;
                  } else {
                    touchedIndex = pieTouchResponse.touchedSectionIndex;
                  }
                });
              }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections()),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: appBaseColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: appLabelFontStyle.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: appBaseColor,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: chartAvgColor,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: appLabelFontStyle.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            badgeWidget: _Badge(
              'assets/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: chartAvgColor,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: chartComplementaryColor1,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: appLabelFontStyle.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            badgeWidget: _Badge(
              'assets/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: chartComplementaryColor1,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: chartComplementaryColor2,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: appLabelFontStyle.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: chartComplementaryColor2,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          return null;
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key key,
    @required this.size,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 3,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.8),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: DankLabel(
          displayText: 'N',
          textStyle: appInputFontStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
