class Question {
  String name;
  String questionText;
  List<String> answers;

  Question({required this.name, required this.questionText, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {

    var answersJson = json['answers'];
    List<String> answers = answersJson != null ? List.from(answersJson) : List.empty();
    return Question(name: json['name'], questionText: json['questionText'], answers: answers);
  }
}