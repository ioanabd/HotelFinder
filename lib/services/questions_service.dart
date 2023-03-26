import 'dart:convert';
import 'dart:io';

import 'package:hotel_finder/models/question.dart';
import 'package:http/http.dart' as http;

import '../models/hotel.dart';

class QuestionService{
  final String _baseUri = 'https://10.0.2.2:7250';
  final String _questionsResource = 'api/Questions';
  final Duration _timeout = const Duration(seconds: 25);

  Future<List<Question>> getQuestions() async{
    try {
      var response = await http.get(Uri.parse('$_baseUri/$_questionsResource'))
          .timeout(_timeout);

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> body = jsonDecode(response.body);
        var questions = body.map((e) => Question.fromJson(e)).toList();
        return questions;
      } else {
        throw Exception('GET questions error: ${response.statusCode}');
      }
    } catch (ex) {
      throw Exception('Unhandled exception');
    }
  }

  Future<List<Hotel>> getHotels(List<Question> answers) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUri/$_questionsResource'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(answers)).timeout(_timeout);

      if(response.statusCode == 201){
        var x = response.body;
        return [];
      } else {
        throw Exception('Failed to retrieve hotels!');
      }
    } catch (ex) {
      throw Exception('Unhandled exception');
    }
  }


}