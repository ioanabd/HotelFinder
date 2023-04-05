import 'package:flutter/cupertino.dart';
import 'package:hotel_finder/services/questions_service.dart';
import '../models/hotel.dart';
import '../models/question.dart';

class QuestionProvider extends ChangeNotifier{
  final QuestionService _questionService = QuestionService();
  List<Question> questions = [];
  List<Hotel> hotels = [];

  late Future getQuestionsFuture;

  QuestionProvider(){
    getQuestionsFuture = _getQuestionsFuture();
  }

  Future _getQuestionsFuture() async {
    questions = await _questionService.getQuestions();
  }

  Future getHotelsFuture(List<Question> answers) async {
    hotels = await _questionService.getHotels(answers);
  }
}