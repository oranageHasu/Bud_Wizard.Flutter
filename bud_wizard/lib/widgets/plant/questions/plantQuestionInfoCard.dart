import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantQuestionInfoCard extends StatelessWidget {
  final Question question;

  PlantQuestionInfoCard({
    @required Question question,
  }) : this.question = question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.0,
      margin: EdgeInsets.only(
        left: 5.0,
        right: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 25.0,
            decoration: BoxDecoration(
              color: (question.isVerified) ? appSuccessColor : appErrorColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.5),
                topRight: Radius.circular(2.5),
              ),
            ),
            child: DankLabel(
              displayText: question.answers.length.toString(),
              textAlign: TextAlign.center,
              textStyle: appLabelFontStyle.copyWith(
                color: appThirdColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Container(
            height: 25.0,
            decoration: BoxDecoration(
              color: (question.isVerified) ? appSuccessColor : appErrorColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2.5),
                bottomRight: Radius.circular(2.5),
              ),
            ),
            child: DankLabel(
              displayText:
                  (question.answers.length == 1) ? 'Answer' : 'Answers',
              textAlign: TextAlign.center,
              textStyle: appInputHintFontStyle.copyWith(
                color: appThirdColor,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.all(2.5),
            ),
          ),
          DankLabel(
            displayText: (true) ? '2 Views' : '1 View',
            textAlign: TextAlign.center,
            textStyle: appLabelFontStyle.copyWith(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.all(2.5),
          ),
        ],
      ),
    );
  }
}
