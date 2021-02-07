import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DankBarChartDataLabel {
  double value;
  String label;
  String brand;

  DankBarChartDataLabel({
    @required double value,
    @required String label,
    String brand,
  })  : this.value = value,
        this.label = label,
        this.brand = brand;
}

class DankBarChartData {
  List<double> data;
  String title;

  DankBarChartData({
    @required List<double> data,
    @required String title,
  })  : this.data = data,
        this.title = title;
}

class DankBarChart extends StatefulWidget {
  final DankBarChartData chartData;
  final List<DankBarChartDataLabel> xAxisLabels;
  final List<DankBarChartDataLabel> yAxisLabels;
  final Color chartBackgroundColor;
  final Border border;
  final bool showYAxisTitles;
  final bool showXAxisTitles;
  final bool showGridLines;
  final String xAxisTitle;
  final String yAxisTitle;

  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  DankBarChart({
    @required DankBarChartData chartData,
    @required List<DankBarChartDataLabel> xAxisLabels,
    @required List<DankBarChartDataLabel> yAxisLabels,
    Color chartBackgroundColor = appDarkBackgroundColor,
    bool showGridLines = false,
    bool showYAxisTitles = true,
    bool showXAxisTitles = true,
    String xAxisTitle = '',
    String yAxisTitle = '',
    Border border = const Border(
      bottom: BorderSide(
        color: chartLinesColor,
        width: 1,
      ),
      left: BorderSide(
        color: chartLinesColor,
        width: 1,
      ),
      right: BorderSide(
        color: Colors.transparent,
      ),
      top: BorderSide(
        color: Colors.transparent,
      ),
    ),
  })  : this.chartData = chartData,
        this.xAxisLabels = xAxisLabels,
        this.yAxisLabels = yAxisLabels,
        this.chartBackgroundColor = chartBackgroundColor,
        this.border = border,
        this.showGridLines = showGridLines,
        this.showYAxisTitles = showYAxisTitles,
        this.showXAxisTitles = showXAxisTitles,
        this.xAxisTitle = xAxisTitle,
        this.yAxisTitle = yAxisTitle;

  @override
  _DankBarChartState createState() => _DankBarChartState();
}

class _DankBarChartState extends State<DankBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int _touchedIndex;

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
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DankLabel(
                displayText: widget.chartData.title,
                textAlign: TextAlign.center,
                textStyle: appInputLabelFontStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 15.0,
                ),
              ),
              Container(
                height: 250.0,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 30.0,
                    left: 15.0,
                    bottom: 10.0,
                  ),
                  child: BarChart(
                    mainBarData(),
                    swapAnimationDuration: animDuration,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      groupsSpace: 5,
      minY: getYAxisMin(),
      maxY: getYAxisMax(),
      gridData: FlGridData(
        show: widget.showGridLines,
        checkToShowHorizontalLine: (value) {
          return containsYAxisLabel(value);
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: chartLinesColor,
            strokeWidth: 1,
          );
        },
      ),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 5.0,
            tooltipPadding: EdgeInsets.all(8),
            tooltipBgColor: Colors.blueGrey.withOpacity(0.4),
            maxContentWidth: 300.0,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.y.toString() + 'ml',
                appInputLabelFontStyle.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              _touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              _touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: widget.showXAxisTitles,
          reservedSize: 22,
          getTextStyles: (value) => appChartXAxisFontStyle,
          margin: 10,
          getTitles: findXAxisLabel,
          checkToShowTitle:
              (minValue, maxValue, sideTitles, appliedInterval, value) {
            return true;
          },
        ),
        leftTitles: SideTitles(
          showTitles: widget.showYAxisTitles,
          getTextStyles: (value) => appChartYAxisFontStyle,
          getTitles: findYAxisLabel,
          margin: 10,
          reservedSize: 45,
          interval: 5,
          checkToShowTitle:
              (minValue, maxValue, sideTitles, appliedInterval, value) {
            return true;
          },
        ),
      ),
      axisTitleData: FlAxisTitleData(
        bottomTitle: AxisTitle(
          showTitle: true,
          titleText: widget.xAxisTitle,
          textStyle: appInputHintFontStyle,
        ),
        leftTitle: AxisTitle(
          showTitle: true,
          titleText: widget.yAxisTitle,
          textStyle: appInputHintFontStyle,
          margin: 5.5,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: widget.border,
      ),
      barGroups: buildGroups(),
    );
  }

  List<BarChartGroupData> buildGroups() {
    List<BarChartGroupData> retval = List<BarChartGroupData>();
    int index = 0;

    for (double value in widget.chartData.data) {
      retval.add(
        buildGroup(
          index,
          value,
          isTouched: index == _touchedIndex,
        ),
      );

      index++;
    }

    return retval;
  }

  BarChartGroupData buildGroup(
    int x,
    double y, {
    bool isTouched = false,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 10 : y,
          colors: isTouched ? [chartMonochromaticColor] : [appBaseColor],
          width: 40,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  String findXAxisLabel(double value) {
    String retval = '';

    for (DankBarChartDataLabel label in widget.xAxisLabels) {
      if (label.value == value) {
        retval = label.label;
      }
    }

    return retval;
  }

  String findYAxisLabel(double value) {
    String retval = '';

    for (DankBarChartDataLabel label in widget.yAxisLabels) {
      if (label.value == value) {
        retval = value.toString() + label.label;
      }
    }

    return retval;
  }

  bool containsYAxisLabel(double value) {
    bool retval = false;

    for (DankBarChartDataLabel label in widget.yAxisLabels) {
      if (label.value == value) {
        retval = true;
        break;
      }
    }

    return retval;
  }

  bool containsXAxisLabel(double value) {
    bool retval = false;

    for (DankBarChartDataLabel label in widget.xAxisLabels) {
      if (label.value == value) {
        retval = true;
        break;
      }
    }

    return retval;
  }

  double getYAxisMin() {
    double retval = 0;

    for (DankBarChartDataLabel label in widget.yAxisLabels) {
      if (label.value < retval) {
        retval = label.value;
      }
    }

    return retval;
  }

  double getYAxisMax() {
    double retval = 0;

    for (DankBarChartDataLabel label in widget.yAxisLabels) {
      if (label.value > retval) {
        retval = label.value;
      }
    }

    return retval;
  }
}
