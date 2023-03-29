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
    // questions = await _questionService.getQuestions();
    questions = [new Question(name: 'intrebare 1', questionText: 'Cati ani ai?', answers: ['Cati ani ai?1', 'Cati ani ai?2', 'Cati ani ai?3']), new Question(name: 'intrebare 1', questionText: 'Cati ani ai?', answers: ['1', '2', '3'])];
  }

  Future getHotelsFuture(List<Question> answers) async {
    // hotels = await _questionService.getHotels(answers);
    var hotel = new Hotel(Name: "Hotel Imperial Premium", PropertyType: "Hotel", Capacity: "20", Stars: "4", Breakfast: "da", Facilities: ["Wi-fi", "Parcare", "Recepție non-stop", "Sală fitness", "Saună", "Spa"], RoomFacilities: ["Frigider", "Prosoape", "Cadă", "Tv", "Uscător de păr", "Priveliște"], PrivateBathroom: "da", Rating: "Superb 9+", DistanceToCenter: "Mai puțin de 3 km");
    var hotel2 = new Hotel(Name: "Pensiunea Vlad", PropertyType: "Hotel", Capacity: "6", Stars: "3", Breakfast: "nu", Facilities: ["Wi-fi", "Parcare", "Recepție non-stop"], RoomFacilities: ["Balcon", "Bucătărie", "Frigider", "Prosoape", "Cadă", "Tv", "Priveliște"], PrivateBathroom: "da", Rating: "Bine 7+", DistanceToCenter: "Mai puțin de 3 km");
    hotels.add(hotel);
    hotels.add(hotel2);
  }
}