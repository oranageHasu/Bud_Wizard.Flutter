import 'package:bud_wizard/models/plant%20system/plant.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/services/api%20services/api-question.dart';
import 'package:bud_wizard/widgets/navigation%20system/noDataError.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestionList.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-loading.dart';
import 'package:flutter/material.dart';

class PlantQuestions extends StatefulWidget {
  final Plant currentPlant;

  PlantQuestions({
    @required Plant currentPlant,
  }) : this.currentPlant = currentPlant;

  @override
  _PlantJournalState createState() => _PlantJournalState(
        this.currentPlant,
      );
}

class _PlantJournalState extends State<PlantQuestions> {
  Plant currentPlant;
  Future<List<Question>> _questions;

  _PlantJournalState(
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
  void didUpdateWidget(PlantQuestions oldWidget) {
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
          return PlantQuestionList(questions: snapshot.data);
        } else if (snapshot.hasError) {
          return NoDataError();
        }

        return retval;
      },
    );
  }
}
