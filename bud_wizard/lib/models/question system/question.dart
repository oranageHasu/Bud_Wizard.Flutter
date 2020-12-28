import 'package:bud_wizard/models/question%20system/answer.dart';
import 'package:flutter_guid/flutter_guid.dart';

class Question {
  final Guid questionId;
  final Guid plantId;
  String questionText;
  DateTime dateAsked = DateTime.now();
  List<Answer> answers = new List<Answer>();
  bool isVerified = false;
  bool isDeleted = false;

  Question({
    this.questionId,
    this.plantId,
    this.questionText,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    Question retval = new Question(
      questionId: new Guid(json['questionId']),
      plantId: new Guid(json['plantId']),
      questionText: json['questionText'],
    );

    retval.dateAsked = DateTime.parse(json['dateAsked']);
    retval.answers = (json['answers'] as List)
        .map((answers) => new Answer.fromJson(answers))
        .toList();

    retval.isVerified = json['isVerified'];
    retval.isDeleted = json['isDeleted'];

    return retval;
  }
}
