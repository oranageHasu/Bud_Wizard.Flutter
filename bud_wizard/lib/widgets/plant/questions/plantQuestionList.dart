import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestion.dart';
import 'package:flutter/material.dart';

class PlantQuestionList extends StatelessWidget {
  final List<Question> questions;

  PlantQuestionList({
    @required List<Question> questions,
  }) : this.questions = questions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        PlantQuestion(question: questions[0]),
        PlantQuestion(question: questions[1]),
      ],
    );
  }
}
