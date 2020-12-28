import 'package:flutter_guid/flutter_guid.dart';

class Answer {
  final Guid answerId;
  final Guid questionId;
  final String username;
  final DateTime answerDate;
  final String answerText;

  Answer({
    this.answerId,
    this.questionId,
    this.username,
    this.answerDate,
    this.answerText,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerId: new Guid(json['answerId']),
      questionId: new Guid(json['questionId']),
      username: json['username'],
      answerDate: DateTime.parse(json['answerDate']),
      answerText: json['answerText'],
    );
  }
}
