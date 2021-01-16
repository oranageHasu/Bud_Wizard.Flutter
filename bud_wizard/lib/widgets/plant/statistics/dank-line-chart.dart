import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-checkbox.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DankLineChartData {
  List<FlSpot> plotData;
  List<Color> plotColor;
  String title;

  DankLineChartData({
    @required List<FlSpot> plotData,
    @required List<Color> plotColor,
    @required String title,
  })  : this.plotData = plotData,
        this.plotColor = plotColor,
        this.title = title;
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
  final Color chartBackgroundColor;
  final double barWidth;
  final bool showXAxisTitles;
  final bool showYAxisTitles;
  final bool showGridLines;
  final bool isCurved;
  final bool showDotData;
  final bool showBelowBarData;
  final Border border;
  final String alternativeDataTitle;
  final List<DankLineChartData> alternativeData;

  DankLineChart({
    @required String title,
    @required List<DankLineChartData> data,
    @required List<DankLineChartDataLabel> xAxisLabels,
    @required List<DankLineChartDataLabel> yAxisLabels,
    Color chartBackgroundColor = appBackgroundColor,
    double barWidth = 4.0,
    bool showXAxisTitles = true,
    bool showYAxisTitles = true,
    bool showGridLines = false,
    bool isCurved = true,
    bool showDotData = true,
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
        this.chartBackgroundColor = chartBackgroundColor,
        this.barWidth = barWidth,
        this.showXAxisTitles = showXAxisTitles,
        this.showYAxisTitles = showYAxisTitles,
        this.showGridLines = showGridLines,
        this.isCurved = isCurved,
        this.showDotData = showDotData,
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
                  padding: EdgeInsets.only(right: 30.0, left: 15.0),
                  child: LineChart(
                    buildLineChartData(),
                    swapAnimationDuration: Duration(milliseconds: 250),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
            left: 670.0,
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
            color: chartData.plotColor[0],
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
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
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
        ),
        leftTitles: SideTitles(
          showTitles: widget.showYAxisTitles,
          getTextStyles: (value) => appChartYAxisFontStyle,
          getTitles: findYAxisLabel,
          margin: 10,
          reservedSize: 45,
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
    );
  }

  List<LineChartBarData> buildLinesBarData() {
    List<LineChartBarData> retval = new List<LineChartBarData>();

    for (DankLineChartData chartData in widget.data) {
      retval.add(
        LineChartBarData(
          spots: chartData.plotData,
          isCurved: widget.isCurved,
          barWidth: widget.barWidth,
          colors: chartData.plotColor,
          dotData: FlDotData(
            show: widget.showDotData,
          ),
          belowBarData: BarAreaData(
            show: widget.showBelowBarData,
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
