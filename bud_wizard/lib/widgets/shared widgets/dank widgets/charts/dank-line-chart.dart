import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-checkbox.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DankLineChartData {
  List<FlSpot> plotData;
  List<Color> plotColor;
  List<double> plotColorStops;
  List<int> pointsOfInterestIndexs;
  List<String> pointsOfInterestNotations;
  String title;

  DankLineChartData({
    @required List<FlSpot> plotData,
    @required List<Color> plotColor,
    @required List<double> plotColorStops,
    @required String title,
    List<int> pointsOfInterestIndexs = const [],
    List<String> pointsOfInterestNotations,
  })  : this.plotData = plotData,
        this.plotColor = plotColor,
        this.plotColorStops = plotColorStops,
        this.title = title,
        this.pointsOfInterestIndexs = pointsOfInterestIndexs,
        this.pointsOfInterestNotations = pointsOfInterestNotations;
}

class DankLineChartDataLabel {
  double value;
  String label;

  DankLineChartDataLabel({
    @required double value,
    @required String label,
  })  : this.value = value,
        this.label = label;
}

class DankLineChart extends StatefulWidget {
  final String title;
  final List<DankLineChartData> data;
  final List<DankLineChartDataLabel> xAxisLabels;
  final List<DankLineChartDataLabel> yAxisLabels;
  final String xAxisTitle;
  final String yAxisTitle;
  final Color chartBackgroundColor;
  final double barWidth;
  final bool showXAxisTitles;
  final bool showYAxisTitles;
  final bool showGridLines;
  final bool isCurved;
  final bool showDotData;
  final bool showFixedDotDisplay;
  final bool showBelowBarData;
  final Border border;
  final String alternativeDataTitle;
  final List<DankLineChartData> alternativeData;

  DankLineChart({
    @required String title,
    @required List<DankLineChartData> data,
    @required List<DankLineChartDataLabel> xAxisLabels,
    @required List<DankLineChartDataLabel> yAxisLabels,
    String xAxisTitle = '',
    String yAxisTitle = '',
    Color chartBackgroundColor = appBackgroundColor,
    double barWidth = 4.0,
    bool showXAxisTitles = true,
    bool showYAxisTitles = true,
    bool showGridLines = false,
    bool isCurved = true,
    bool showDotData = true,
    bool showFixedDotDisplay = false,
    bool showBelowBarData = false,
    String alternativeDataTitle = '<Title Here>',
    List<DankLineChartData> alternativeData,
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
  })  : this.title = title,
        this.data = data,
        this.xAxisLabels = xAxisLabels,
        this.yAxisLabels = yAxisLabels,
        this.xAxisTitle = xAxisTitle,
        this.yAxisTitle = yAxisTitle,
        this.chartBackgroundColor = chartBackgroundColor,
        this.barWidth = barWidth,
        this.showXAxisTitles = showXAxisTitles,
        this.showYAxisTitles = showYAxisTitles,
        this.showGridLines = showGridLines,
        this.isCurved = isCurved,
        this.showDotData = showDotData,
        this.showFixedDotDisplay = showFixedDotDisplay,
        this.showBelowBarData = showBelowBarData,
        this.border = border,
        this.alternativeDataTitle = alternativeDataTitle,
        this.alternativeData = alternativeData;

  @override
  _DankLineChartState createState() => _DankLineChartState();
}

class _DankLineChartState extends State<DankLineChart> {
  bool _onlyShowingMainData = false;

  @override
  void initState() {
    super.initState();
  }

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
            children: <Widget>[
              DankLabel(
                displayText: widget.title,
                textStyle: appInputLabelFontStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                ),
              ),
              Container(
                height: 200.0,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 30.0,
                    left: 15.0,
                    bottom: 10.0,
                  ),
                  child: LineChart(
                    buildLineChartData(),
                    swapAnimationDuration: Duration(milliseconds: 250),
                  ),
                ),
              ),
            ],
          ),
          (widget.alternativeData != null)
              ? Positioned(
                  top: 10.0,
                  left: 7.0,
                  child: Row(
                    children: [
                      DankCheckbox(
                        value: !_onlyShowingMainData,
                        margin: EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _onlyShowingMainData = !value;
                          });
                        },
                      ),
                      DankLabel(
                        displayText: widget.alternativeDataTitle,
                        textStyle: appInputHintFontStyle,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          Positioned(
            top: 10.0,
            left: 640.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (DankLineChartData chartData in widget.data)
                  legendItem(chartData),
                if (!_onlyShowingMainData && widget.alternativeData != null)
                  for (DankLineChartData chartData in widget.alternativeData)
                    legendItem(chartData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget legendItem(DankLineChartData chartData) {
    return Row(
      children: [
        Container(
          width: 20.0,
          height: 4.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (chartData.plotColor.length == 1)
                  ? null
                  : chartData.plotColor,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          margin: EdgeInsets.only(right: 5.0),
        ),
        DankLabel(
          displayText: chartData.title,
          textStyle: appLabelFontStyle.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }

  LineChartData buildLineChartData() {
    final List<LineChartBarData> lineBarsData = buildLinesBarData();
    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return LineChartData(
      gridData: FlGridData(
        show: widget.showGridLines,
        drawVerticalLine: true,
        checkToShowHorizontalLine: (value) {
          return containsYAxisLabel(value);
        },
        checkToShowVerticalLine: (value) {
          return containsXAxisLabel(value);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: chartLinesColor,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: chartLinesColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
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
      borderData: FlBorderData(
        show: true,
        border: widget.border,
      ),
      minX: getXAxisMin(),
      maxX: getXAxisMax(),
      minY: getYAxisMin(),
      maxY: getYAxisMax(),
      lineBarsData: buildLinesBarData(),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 5.0,
            tooltipPadding: EdgeInsets.all(8),
            tooltipBgColor: Colors.blueGrey.withOpacity(0.4),
            maxContentWidth: 300.0,
            getTooltipItems: (lineBarSpots) {
              List<LineTooltipItem> retval = List<LineTooltipItem>();

              for (LineBarSpot spot in lineBarSpots) {
                String text = spot.y.toString() + widget.yAxisLabels[0].label;
                if (widget.data[0].pointsOfInterestNotations != null) {
                  bool opResult = widget.data[0].pointsOfInterestIndexs
                      .contains(spot.spotIndex);

                  if (opResult) {
                    text = text +
                        '\n' +
                        widget.data[0].pointsOfInterestNotations[widget
                            .data[0].pointsOfInterestIndexs
                            .indexOf(spot.spotIndex)];
                  }
                }

                retval.add(
                  LineTooltipItem(
                    text,
                    appInputLabelFontStyle.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return retval;
            }),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: !widget.showFixedDotDisplay,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: lerpGradient(barData.colors, barData.colorStops,
                    (index / barData.spots.length)),
                strokeWidth: 1.5,
              ),
              FlDotData(
                show: widget.showFixedDotDisplay,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  color: lerpGradient(
                      barData.colors, barData.colorStops, percent / 100),
                  strokeWidth: 2,
                  strokeColor: Colors.black,
                ),
              ),
            );
          }).toList();
        },
      ),
      showingTooltipIndicators:
          widget.data[0].pointsOfInterestIndexs.map((index) {
        return ShowingTooltipIndicators(
          index,
          [
            LineBarSpot(
              tooltipsOnBar,
              lineBarsData.indexOf(tooltipsOnBar),
              tooltipsOnBar.spots[index],
            ),
          ],
        );
      }).toList(),
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
    );
  }

  List<LineChartBarData> buildLinesBarData() {
    List<LineChartBarData> retval = new List<LineChartBarData>();

    for (DankLineChartData chartData in widget.data) {
      retval.add(
        LineChartBarData(
          showingIndicators: chartData.pointsOfInterestIndexs,
          spots: chartData.plotData,
          isCurved: widget.isCurved,
          barWidth: widget.barWidth,
          colors: chartData.plotColor,
          dotData: FlDotData(
            show: widget.showDotData,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: 5,
              color: lerpGradient(
                  barData.colors, barData.colorStops, percent / 100),
              strokeWidth: 2,
              strokeColor: Colors.black.withOpacity(0.5),
            ),
          ),
          belowBarData: BarAreaData(
            show: widget.showBelowBarData,
            gradientColorStops: chartData.plotColorStops,
            colors: chartData.plotColor
                .map((color) => color.withOpacity(0.15))
                .toList(),
          ),
        ),
      );
    }

    if (!_onlyShowingMainData && widget.alternativeData != null) {
      for (DankLineChartData chartData in widget.alternativeData) {
        retval.add(
          LineChartBarData(
            spots: chartData.plotData,
            isCurved: widget.isCurved,
            barWidth: widget.barWidth,
            colors: chartData.plotColor,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        );
      }
    }

    return retval;
  }

  // Lerps between a [LinearGradient] colors, based on [t]
  Color lerpGradient(List<Color> colors, List<double> stops, double t) {
    if (stops == null || stops.length != colors.length) {
      stops = [];

      // provided gradientColorStops is invalid and we calculate it here
      colors.asMap().forEach((index, color) {
        final percent = 1.0 / colors.length;
        stops.add(percent * index);
      });
    }

    for (var s = 0; s < stops.length - 1; s++) {
      final leftStop = stops[s], rightStop = stops[s + 1];
      final leftColor = colors[s], rightColor = colors[s + 1];
      if (t <= leftStop) {
        return leftColor;
      } else if (t < rightStop) {
        final sectionT = (t - leftStop) / (rightStop - leftStop);
        return Color.lerp(leftColor, rightColor, sectionT);
      }
    }
    return colors.last;
  }

  bool containsYAxisLabel(double value) {
    bool retval = false;

    for (DankLineChartDataLabel label in widget.yAxisLabels) {
      if (label.value == value) {
        retval = true;
        break;
      }
    }

    return retval;
  }

  bool containsXAxisLabel(double value) {
    bool retval = false;

    for (DankLineChartDataLabel label in widget.xAxisLabels) {
      if (label.value == value) {
        retval = true;
        break;
      }
    }

    return retval;
  }

  String findYAxisLabel(double value) {
    String retval = '';

    for (DankLineChartDataLabel label in widget.yAxisLabels) {
      if (label.value == value) {
        retval = value.toString() + label.label;
      }
    }

    return retval;
  }

  String findXAxisLabel(double value) {
    String retval = '';

    for (DankLineChartDataLabel label in widget.xAxisLabels) {
      if (label.value == value) {
        retval = label.label;
      }
    }

    return retval;
  }

  double getXAxisMin() {
    double retval = 0;

    for (DankLineChartDataLabel label in widget.xAxisLabels) {
      if (label.value < retval) {
        retval = label.value;
      }
    }

    return retval;
  }

  double getXAxisMax() {
    double retval = 0;

    for (DankLineChartDataLabel label in widget.xAxisLabels) {
      if (label.value > retval) {
        retval = label.value;
      }
    }

    return retval;
  }

  double getYAxisMin() {
    double retval = 0;

    for (DankLineChartDataLabel label in widget.yAxisLabels) {
      if (label.value < retval) {
        retval = label.value;
      }
    }

    return retval;
  }

  double getYAxisMax() {
    double retval = 0;

    for (DankLineChartDataLabel label in widget.yAxisLabels) {
      if (label.value > retval) {
        retval = label.value;
      }
    }

    return retval;
  }
}
