import 'dart:convert';
import 'dart:io';

import 'package:hotel_finder/models/question.dart';
import 'package:http/http.dart';

class QuestionService{
  final String _baseUri = 'https:192.168.0.104';
  final String _questionsResource = '/api/Questions';
  final Duration _timeout = const Duration(seconds: 25);

  Future<List<Question>> getQuestions() async{
    try {
      var response = await get(Uri.parse('$_baseUri/$_questionsResource'))
          .timeout(_timeout);

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> body = jsonDecode(response.body);
        var questions = body.map((e) => Question.fromJson(e)).toList();
        return questions;
      } else {
        throw Exception('GET questions error: ${response.statusCode}');
      }
    } catch (ex, stackTrace) {
      throw Exception('Unhandled exception');
    }
  }
}