import 'package:flutter/cupertino.dart';
import 'package:hotel_finder/services/questions_service.dart';
import '../models/question.dart';

class QuestionProvider extends ChangeNotifier{
  final QuestionService _questionService = QuestionService();
  List<Question> questions = [];

  late Future getQuestionsFuture;

  QuestionProvider(){
    getQuestionsFuture = _getQuestionsFuture();
  }

  Future _getQuestionsFuture() async {
    questions = await _questionService.getQuestions();
  }
}