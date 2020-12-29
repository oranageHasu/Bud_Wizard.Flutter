import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-expanded-section.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantQuestion extends StatefulWidget {
  final Question question;

  PlantQuestion({
    @required Question question,
  }) : this.question = question;

  @override
  _PlantQuestionState createState() => _PlantQuestionState(
        this.question,
      );
}

class _PlantQuestionState extends State<PlantQuestion> {
  Question question;
  bool _expanded = false;

  _PlantQuestionState(
    this.question,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(PlantQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);

    question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Colors.black.withOpacity(0.2),
              splashColor: Colors.black.withOpacity(0.2),
              onTap: expandQuestion,
              child: Container(
                color: appBaseBackgroundColor,
                child: DankLabel(
                  displayText: question.questionText,
                  textStyle: appLabelFontStyle,
                  padding: EdgeInsets.all(5.0),
                ),
              ),
            ),
          ),
          DankExpandedSection(
            expand: _expanded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (Answer answer in question.answers)
                  Container(
                    color: appThirdColor,
                    margin: EdgeInsets.only(
                      left: 10.0,
                      top: 5.0,
                    ),
                    child: DankLabel(
                      displayText: answer.answerText,
                      textStyle: appLabelFontStyle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void expandQuestion() {
    setState(() {
      _expanded = !_expanded;
    });
  }
}
