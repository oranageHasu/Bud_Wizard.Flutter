import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:bud_wizard/widgets/plant/questions/plantQuestionAnswer.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-button.dart';
import 'package:flutter/material.dart';

class PlantQuestionAnswerList extends StatelessWidget {
  final List<Answer> answers;
  final bool isVerified;

  PlantQuestionAnswerList({
    @required List<Answer> answers,
    bool isVerified = false,
  })  : this.answers = answers,
        this.isVerified = isVerified;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (Answer answer in answers) PlantQuestionAnswer(answer: answer),
        (!isVerified)
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
    );
  }

  void addAnswer() {
    print('To Do: Add Answer');
  }
}
