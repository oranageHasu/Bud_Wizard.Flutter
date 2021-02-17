import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dankBasicTooltip.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DankPieChartDataItem {
  double value;
  String unit;
  String iconPath;
  String label;
  String labelAbbr;
  Color color;

  DankPieChartDataItem({
    @required double value,
    @required String unit,
    @required String iconPath,
    @required String label,
    @required String labelAbbr,
    @required Color color,
  })  : this.value = value,
        this.unit = unit,
        this.iconPath = iconPath,
        this.label = label,
        this.labelAbbr = labelAbbr,
        this.color = color;
}

class DankPieChartData {
  List<DankPieChartDataItem> data;
  String title;

  DankPieChartData({
    @required List<DankPieChartDataItem> data,
    @required String title,
  })  : this.data = data,
        this.title = title;
}

class DankPieChart extends StatefulWidget {
  final Color chartBackgroundColor;
  final DankPieChartData chartData;

  DankPieChart({
    @required DankPieChartData chartData,
    Color chartBackgroundColor = appDarkBackgroundColor,
  })  : this.chartData = chartData,
        this.chartBackgroundColor = chartBackgroundColor;

  @override
  _DankPieChartState createState() => _DankPieChartState();
}

class _DankPieChartState extends State<DankPieChart> {
  int _touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        right: 10.0,
      ),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: widget.chartBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DankLabel(
                displayText: widget.chartData.title,
                textStyle: appInputLabelFontStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.only(
                  bottom: 15.0,
                ),
              ),
              Container(
                height: 240.0,
                width: 250.0,
                child: PieChart(
                  PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          _touchedIndex = -1;
                        } else {
                          _touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: buildChartSections(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildLegend(),
          ),
        ],
      ),
    );
  }

  Widget _chartLegendItem(DankPieChartDataItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(
              left: 25.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
          DankLabel(
            displayText: item.label,
            textStyle: appLabelFontStyle.copyWith(
              fontSize: 14.0,
              color: appBaseWhiteTextColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildLegend() {
    List<Widget> retval = new List<Widget>();

    for (DankPieChartDataItem item in widget.chartData.data) {
      retval.add(_chartLegendItem(item));
    }

    return retval;
  }

  List<PieChartSectionData> buildChartSections() {
    List<PieChartSectionData> retval = new List<PieChartSectionData>();
    int index = 0;
    bool isTouched;

    for (DankPieChartDataItem item in widget.chartData.data) {
      isTouched = index == _touchedIndex;

      retval.add(
        PieChartSectionData(
          color: item.color,
          value: item.value,
          title: item.value.toString() + item.unit,
          radius: (isTouched) ? 110 : 100,
          titleStyle: appLabelFontStyle.copyWith(
            fontSize: (isTouched) ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: appBaseWhiteTextColor,
          ),
          badgeWidget: _Badge(
            item.iconPath,
            label: item.labelAbbr,
            mouseHoverText: item.label,
            size: (isTouched) ? 55 : 40,
            borderColor: item.color,
            isTouched: isTouched,
          ),
          badgePositionPercentageOffset: .98,
        ),
      );

      index++;
    }

    return retval;
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final String label;
  final String mouseHoverText;
  final double size;
  final Color borderColor;
  final bool isTouched;

  const _Badge(
    this.svgAsset, {
    Key key,
    @required this.size,
    @required this.borderColor,
    @required this.label,
    @required this.mouseHoverText,
    this.isTouched = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DankBasicTooltip(
      tooltipText: mouseHoverText,
      child: AnimatedContainer(
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
            displayText: label,
            textStyle: appInputFontStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: (isTouched) ? 25.0 : 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
