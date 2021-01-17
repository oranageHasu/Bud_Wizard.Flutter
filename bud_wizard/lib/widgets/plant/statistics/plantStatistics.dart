import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/services/api%20services/api-question.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/charts/dank-line-chart.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PlantStatistics extends StatefulWidget {
  final Plant currentPlant;

  PlantStatistics({
    @required Plant currentPlant,
  }) : this.currentPlant = currentPlant;

  @override
  _PlantStatisticsState createState() => _PlantStatisticsState(
        this.currentPlant,
      );
}

class _PlantStatisticsState extends State<PlantStatistics> {
  Plant currentPlant;
  Future<List<Question>> _questions;

  _PlantStatisticsState(
    this.currentPlant,
  );

  @override
  void initState() {
    super.initState();

    _questions = getQuestions(currentPlant.plantId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PlantStatistics oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPlant != widget.currentPlant) {
      currentPlant = widget.currentPlant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _questions,
      builder: (context, snapshot) {
        Widget retval = DankLoading();

        if (snapshot.hasData) {
          return Column(
            /* Graphs to include:
              - Buid Yield
              - Water Freq
              - Nutrients across time (line graph)
              - Total Nutrient Usage (pie or bar graph)
              - Plant Height over flowering stages (time) (line graph, gradient for plant stages)
            */
            children: [
              buildLineChart(ChartType.BudYieldProjection),
              buildLineChart(ChartType.WateringFrequency),
              buildLineChart(ChartType.HeightOverTime),
            ],
          );
        } else if (snapshot.hasError) {
          return NoDataError();
        }

        return retval;
      },
    );
  }

  Widget buildLineChart(ChartType type) {
    Widget retval;

    switch (type) {
      case ChartType.BudYieldProjection:
        retval = budYieldProject();
        break;
      case ChartType.WateringFrequency:
        retval = wateringFrequency();
        break;
      case ChartType.HeightOverTime:
        retval = heightOverTime();
        break;
    }

    return retval;
  }

  Widget heightOverTime() {
    return DankLineChart(
      title: 'Plant Height Over Time',
      showGridLines: true,
      showBelowBarData: true,
      showFixedDotDisplay: true,
      border: Border.all(
        color: chartLinesColor,
        width: 1,
      ),
      xAxisTitle: 'Time',
      yAxisTitle: 'Height',
      yAxisLabels: [
        DankLineChartDataLabel(
          value: 0,
          label: 'cm',
        ),
        DankLineChartDataLabel(
          value: 50,
          label: 'cm',
        ),
        DankLineChartDataLabel(
          value: 100,
          label: 'cm',
        ),
        DankLineChartDataLabel(
          value: 150,
          label: 'cm',
        ),
        DankLineChartDataLabel(
          value: 200,
          label: 'cm',
        ),
        DankLineChartDataLabel(
          value: 250,
          label: 'cm',
        ),
      ],
      xAxisLabels: [
        DankLineChartDataLabel(
          value: 0,
          label: 'APR',
        ),
        DankLineChartDataLabel(
          value: 30,
          label: 'MAY',
        ),
        DankLineChartDataLabel(
          value: 60,
          label: 'JUN',
        ),
        DankLineChartDataLabel(
          value: 90,
          label: 'JULY',
        ),
        DankLineChartDataLabel(
          value: 120,
          label: 'AUG',
        ),
        DankLineChartDataLabel(
          value: 150,
          label: 'SEPT',
        ),
        DankLineChartDataLabel(
          value: 180,
          label: 'OCT',
        ),
        DankLineChartDataLabel(
          value: 210,
          label: 'DEC',
        ),
        DankLineChartDataLabel(
          value: 240,
          label: 'JAN',
        ),
        DankLineChartDataLabel(
          value: 270,
          label: 'FEB',
        ),
      ],
      data: [
        // Fake User Data
        DankLineChartData(
          title: 'Plant Height Over Time',
          plotColor: [
            growVegetativeColor,
            growFloweringColor,
            growDryingColor,
          ],
          plotData: [
            FlSpot(0, 1),
            FlSpot(14, 12),
            FlSpot(28, 20),
            FlSpot(42, 44),
            FlSpot(85, 59),
            FlSpot(105, 67),
            FlSpot(155, 89),
            FlSpot(210, 137),
            FlSpot(250, 176),
            FlSpot(270, 179),
          ],
          plotColorStops: [0, 200],
          pointsOfInterestIndexs: [5, 8],
          pointsOfInterestNotations: ['Flowering Begins', 'Harvest'],
        ),
      ],
    );
  }

  Widget wateringFrequency() {
    return DankLineChart(
      title: 'Watering Frequency',
      showGridLines: true,
      showBelowBarData: true,
      border: Border.all(
        color: chartLinesColor,
        width: 1,
      ),
      xAxisTitle: 'Time',
      yAxisTitle: 'Amount of Water',
      yAxisLabels: [
        DankLineChartDataLabel(
          value: 0,
          label: 'ml',
        ),
        DankLineChartDataLabel(
          value: 250,
          label: 'ml',
        ),
        DankLineChartDataLabel(
          value: 500,
          label: 'ml',
        ),
        DankLineChartDataLabel(
          value: 750,
          label: 'ml',
        ),
        DankLineChartDataLabel(
          value: 1000,
          label: 'ml',
        ),
      ],
      xAxisLabels: [
        DankLineChartDataLabel(
          value: 0,
          label: 'APR',
        ),
        DankLineChartDataLabel(
          value: 30,
          label: 'MAY',
        ),
        DankLineChartDataLabel(
          value: 60,
          label: 'JUN',
        ),
        DankLineChartDataLabel(
          value: 90,
          label: 'JULY',
        ),
        DankLineChartDataLabel(
          value: 120,
          label: 'AUG',
        ),
        DankLineChartDataLabel(
          value: 150,
          label: 'SEPT',
        ),
        DankLineChartDataLabel(
          value: 180,
          label: 'OCT',
        ),
        DankLineChartDataLabel(
          value: 210,
          label: 'DEC',
        ),
        DankLineChartDataLabel(
          value: 240,
          label: 'JAN',
        ),
        DankLineChartDataLabel(
          value: 270,
          label: 'FEB',
        ),
      ],
      data: [
        // Fake User Data
        DankLineChartData(
          title: 'Daily Water Usage',
          plotColor: [appBaseColor, appBaseColor],
          plotColorStops: [],
          plotData: [
            FlSpot(0, 250),
            FlSpot(14, 350),
            FlSpot(28, 400),
            FlSpot(42, 500),
            FlSpot(105, 700),
            FlSpot(155, 500),
            FlSpot(210, 300),
            FlSpot(270, 300),
          ],
        ),
      ],
      alternativeDataTitle: 'Display Average',
      alternativeData: [
        DankLineChartData(
          title: 'Avg Water Usage',
          plotColor: [chartAvgColor, chartAvgColor],
          plotColorStops: [],
          plotData: [
            FlSpot(0, 412.5),
            FlSpot(270, 412.5),
          ],
        ),
      ],
    );
  }

  Widget budYieldProject() {
    return DankLineChart(
      title: 'Bud Yield Projection',
      xAxisTitle: 'Time',
      yAxisTitle: 'Bud Weight',
      yAxisLabels: [
        DankLineChartDataLabel(
          value: 15,
          label: 'g',
        ),
        DankLineChartDataLabel(
          value: 30,
          label: 'g',
        ),
        DankLineChartDataLabel(
          value: 45,
          label: 'g',
        ),
        DankLineChartDataLabel(
          value: 60,
          label: 'g',
        ),
        DankLineChartDataLabel(
          value: 75,
          label: 'g',
        ),
        DankLineChartDataLabel(
          value: 90,
          label: 'g',
        ),
      ],
      xAxisLabels: [
        DankLineChartDataLabel(
          value: 0,
          label: 'SEPT',
        ),
        DankLineChartDataLabel(
          value: 30,
          label: 'OCT',
        ),
        DankLineChartDataLabel(
          value: 60,
          label: 'DEC',
        ),
        DankLineChartDataLabel(
          value: 90,
          label: 'JAN',
        ),
        DankLineChartDataLabel(
          value: 120,
          label: 'FEB',
        ),
      ],
      data: [
        // Fake User Data
        DankLineChartData(
          title: 'You',
          plotColor: [appBaseColor, appBaseColor],
          plotColorStops: [],
          plotData: [
            FlSpot(1, 10),
            FlSpot(14, 16),
            FlSpot(28, 23),
            FlSpot(42, 40),
            FlSpot(58, 50),
            FlSpot(72, 65),
            FlSpot(105, 85),
          ],
        ),
        // Fake Community Average
        DankLineChartData(
          title: 'Avg User',
          plotColor: [chartAvgUserColor, chartAvgUserColor],
          plotColorStops: [],
          plotData: [
            FlSpot(1, 10),
            FlSpot(15, 12),
            FlSpot(30, 15),
            FlSpot(45, 17),
            FlSpot(60, 40),
            FlSpot(75, 50),
            FlSpot(90, 62),
            FlSpot(105, 70),
            FlSpot(120, 75),
          ],
        ),
      ],
    );
  }
}
