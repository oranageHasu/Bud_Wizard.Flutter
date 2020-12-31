import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/formatter.dart';
import 'package:bud_wizard/models/question%20system/question.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestionAnswerList.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestionInfoCard.dart';
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
              PlantQuestionInfoCard(question: question),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: appBaseBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    DankLabel(
                                      displayText: question.questionTitle,
                                      textStyle:
                                          appLabelHeaderFontStyle.copyWith(
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
                                        textStyle:
                                            appInputHintFontStyle.copyWith(
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
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                hoverColor: Colors.black.withOpacity(0.3),
                                splashColor: Colors.black.withOpacity(0.3),
                                onTap: expandQuestion,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          DankExpandedSection(
            expand: _expanded,
            child: PlantQuestionAnswerList(
              answers: question.answers,
              isVerified: question.isVerified,
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
