import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

class PlantQuestionAnswer extends StatelessWidget {
  final Answer answer;

  PlantQuestionAnswer({
    @required Answer answer,
  }) : this.answer = answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 55.0,
              child: SizedBox.shrink(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: appThirdColor,
                  borderRadius: BorderRadius.circular(5),
                  border: (answer.acceptedAnswer)
                      ? Border.all(
                          color: appSuccessColor,
                          width: 1.5,
                        )
                      : Border.all(color: appThirdColor),
                ),
                padding: EdgeInsets.only(
                  left: 10.0,
                ),
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DankLabel(
                            displayText: answer.answerText,
                            textStyle: appInputFontStyle,
                            textAlign: TextAlign.left,
                            padding: EdgeInsets.only(
                              right: 10.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                          ),
                        ),
                        if (answer.acceptedAnswer)
                          Container(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: appSuccessColor,
                                  size: 18.0,
                                ),
                                DankLabel(
                                  displayText: 'Accepted Answer',
                                  textStyle: appLabelFontStyle.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: appBaseWhiteTextColor,
                          size: 15.0,
                        ),
                        DankLabel(
                          displayText: answer.username,
                          textStyle: appInputHintFontStyle.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 251, 179, 1.0),
                          ),
                          textAlign: TextAlign.left,
                          padding: EdgeInsets.only(
                            right: 15.0,
                            left: 5.0,
                          ),
                        ),
                        Icon(
                          Icons.thumb_up,
                          color: appBaseWhiteTextColor,
                          size: 15.0,
                        ),
                        DankLabel(
                          displayText: '25',
                          textStyle: appLabelFontStyle.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          padding: EdgeInsets.only(
                            right: 15.0,
                            left: 5.0,
                          ),
                        ),
                        Expanded(
                          child: DankLabel(
                            displayText: 'answered ' +
                                formatDateDisplayDetailed(
                                  answer.answerDate,
                                ),
                            textStyle: appInputHintFontStyle.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            padding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
