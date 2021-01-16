import 'package:bud_wizard/models/plant.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/services/api%20services/api-question.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';
import 'package:bud_wizard/widgets/plant/statistics/Dank-Line-Chart.dart';
import 'package:bud_wizard/widgets/plant/statistics/Dank-Line-Chart2.dart';
import 'package:bud_wizard/widgets/plant/statistics/Dank-Line-Chart3.dart';
import 'package:bud_wizard/widgets/plant/statistics/Dank-Line-Chart4.dart';

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
            children: [
              DankLineChart(),
              DankLineChart2(),
              DankLineChart3(),
              DankLineChart4(),
            ],
          );
        } else if (snapshot.hasError) {
          return NoDataError();
        }

        return retval;
      },
    );
  }
}
