import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
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
    int counter = 0;

    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                        color: (question.isVerified)
                            ? appSuccessColor
                            : appErrorColor,
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
                        color: (question.isVerified)
                            ? appSuccessColor
                            : appErrorColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5),
                          bottomRight: Radius.circular(2.5),
                        ),
                      ),
                      child: DankLabel(
                        displayText: 'Answers',
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
                      displayText: '2 Views',
                      textAlign: TextAlign.center,
                      textStyle: appLabelFontStyle.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.all(2.5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        //hoverColor: Colors.white.withOpacity(1),
                        //splashColor: Colors.white.withOpacity(1),
                        onTap: expandQuestion,
                        child: Container(
                          decoration: BoxDecoration(
                            color: appBaseBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.5),
                              topRight: Radius.circular(2.5),
                              bottomLeft: Radius.circular(2.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  DankLabel(
                                    displayText: question.questionTitle,
                                    textStyle: appLabelHeaderFontStyle.copyWith(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: appBaseColor,
                                    ),
                                    textAlign: TextAlign.left,
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                  Expanded(
                                    child: DankLabel(
                                      displayText: 'asked ' +
                                          formatDateDisplayDetailed(
                                            question.dateAsked,
                                          ),
                                      textStyle: appInputHintFontStyle.copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                      padding: EdgeInsets.all(5.0),
                                    ),
                                  ),
                                ],
                              ),
                              DankLabel(
                                displayText: question.questionText,
                                textStyle: appInputFontStyle,
                                textAlign: TextAlign.left,
                                padding: EdgeInsets.all(10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          DankExpandedSection(
            expand: _expanded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (Answer answer in question.answers)
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80.0,
                            child: (answer.acceptedAnswer)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: appSuccessColor,
                                        size: 35.0,
                                      ),
                                      DankLabel(
                                        displayText: 'Accepted Answer',
                                        textStyle: appLabelFontStyle.copyWith(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: appThirdColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                              ),
                              margin: EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: appBaseWhiteTextColor,
                                    size: 15.0,
                                  ),
                                  DankLabel(
                                    displayText: (counter += 1).toString(),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        DankLabel(
                                          displayText: answer.answerText,
                                          textStyle: appInputFontStyle,
                                          textAlign: TextAlign.left,
                                          padding: EdgeInsets.all(5.0),
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
                                              textStyle: appInputHintFontStyle
                                                  .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    255, 251, 179, 1.0),
                                              ),
                                              textAlign: TextAlign.left,
                                              padding: EdgeInsets.all(5.0),
                                            ),
                                            Expanded(
                                              child: DankLabel(
                                                displayText: 'answered ' +
                                                    formatDateDisplayDetailed(
                                                      answer.answerDate,
                                                    ),
                                                textStyle: appInputHintFontStyle
                                                    .copyWith(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.right,
                                                padding: EdgeInsets.all(5.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 100.0,
                          top: 5.0,
                        ),
                        child: Divider(
                          height: 2.0,
                          thickness: 2.0,
                          color: appThirdColor,
                        ),
                      ),
                    ],
                  ),
                (!question.isVerified)
                    ? Align(
                        alignment: FractionalOffset.bottomRight,
                        child: DankButton(
                          buttonText: 'Add Answer',
                          onPressed: addAnswer,
                          buttonType: DankButtonType.Flat,
                          margin: EdgeInsets.only(top: 5.0),
                          padding: EdgeInsets.all(15.0),
                          backgroundColor: Colors.black.withOpacity(0.3),
                          textStyle: appButtonFontStyle.copyWith(
                            color: appBaseWhiteTextColor,
                          ),
                          borderRadius: 2.5,
                        ),
                      )
                    : SizedBox.shrink(),
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

  void addAnswer() {
    print('To Do: Add Answer');
  }
}
