import 'package:flutter_guid/flutter_guid.dart';

class Answer {
  final Guid answerId;
  final Guid questionId;
  final String username;
  final String answerText;
  DateTime answerDate = DateTime.now();
  bool acceptedAnswer = false;

  Answer({
    this.answerId,
    this.questionId,
    this.username,
    this.answerText,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    Answer answer = new Answer(
      answerId: new Guid(json['answerId']),
      questionId: new Guid(json['questionId']),
      username: json['username'],
      answerText: json['answerText'],
    );

    answer.answerDate = DateTime.parse(json['answerDate']);
    answer.acceptedAnswer = json['acceptedAnswer'];

    return answer;
  }
}
