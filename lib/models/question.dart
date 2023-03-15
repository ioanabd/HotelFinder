import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

class Question {
  int id;
  String questionText;
  List<String> answers;

  Question({required this.id, required this.questionText, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {

    var answersJson = jsonDecode(json['answers']);
    List<String> answers = answersJson != null ? List.from(answersJson) : List.empty();
    return Question(id: json['id'], questionText: json['questionText'], answers: answers);
  }
}