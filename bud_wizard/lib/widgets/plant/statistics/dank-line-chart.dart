import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DankLineChart extends StatefulWidget {
  final Color chartBackgroundColor;
  final bool showXAxisTitles;
  final bool showYAxisTitles;
  final bool showGridLines;

  DankLineChart({
    Color chartBackgroundColor = appBackgroundColor,
    bool showXAxisTitles = true,
    bool showYAxisTitles = true,
    bool showGridLines = false,
  })  : this.chartBackgroundColor = chartBackgroundColor,
        this.showXAxisTitles = showXAxisTitles,
        this.showYAxisTitles = showYAxisTitles,
        this.showGridLines = showGridLines;

  @override
  _DankLineChartState createState() => _DankLineChartState(
        this.chartBackgroundColor,
        this.showXAxisTitles,
        this.showYAxisTitles,
        this.showGridLines,
      );
}

class _DankLineChartState extends State<DankLineChart> {
  Color chartBackgroundColor;
  bool showXAxisTitles;
  bool showYAxisTitles;
  bool showGridLines;

  bool _isShowingMainData;

  _DankLineChartState(
    this.chartBackgroundColor,
    this.showXAxisTitles,
    this.showYAxisTitles,
    this.showGridLines,
  );

  @override
  void initState() {
    super.initState();
    _isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: chartBackgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              DankLabel(
                displayText: 'Bud Yield Projection',
                textStyle: appInputLabelFontStyle,
                padding: EdgeInsets.only(top: 20.0),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200.0,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0, left: 6.0),
                  child: LineChart(
                    _isShowingMainData ? sampleData1() : sampleData2(),
                    swapAnimationDuration: Duration(milliseconds: 250),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Positioned(
            top: 10.0,
            left: 7.0,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(_isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  _isShowingMainData = !_isShowingMainData;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: showGridLines,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: showXAxisTitles,
          reservedSize: 22,
          getTextStyles: (value) => appChartXAxisFontStyle,
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 15:
                return 'SEPT';
              case 45:
                return 'OCT';
              case 75:
                return 'DEC';
              case 105:
                return 'JAN';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: showYAxisTitles,
          getTextStyles: (value) => appChartYAxisFontStyle,
          getTitles: (value) {
            switch (value.toInt()) {
              case 15:
                return '15g';
              case 30:
                return '30g';
              case 45:
                return '45g';
              case 60:
                return '60g';
              case 75:
                return '75g';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 2,
          ),
          left: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 2,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 110,
      maxY: 75,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 10),
        FlSpot(14, 16),
        FlSpot(28, 23),
        FlSpot(42, 40),
        FlSpot(58, 50),
        FlSpot(72, 65),
        FlSpot(105, 70),
      ],
      isCurved: true,
      colors: [
        appBaseColor,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 10),
        FlSpot(14, 12),
        FlSpot(28, 15),
        FlSpot(42, 17),
        FlSpot(58, 40),
        FlSpot(72, 50),
        FlSpot(105, 62),
      ],
      isCurved: true,
      colors: [
        appErrorColor,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
