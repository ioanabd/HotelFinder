import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hotel_finder/providers/question_provider.dart';
import 'package:provider/provider.dart';

import '../../models/question.dart';
import '../../widgets/custom_appbar.dart';
import '../hotels/hotel_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  List<Question> _questionAnswered = [];

  var _questionIndex = 0;

  List _facilitiesAnswers = [];
  List _roomFacilitiesAnswers = [];
  String _answer = '';

  @override
  Widget build(BuildContext context) {
    var questionsProvider = context.watch<QuestionProvider>();
    return FutureBuilder(
        future: questionsProvider.getQuestionsFuture,
        builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.hasError) {
              return const Center(child: Text('Could not retrieve questions!'));
            }
            return SafeArea(
              child: Scaffold(
                appBar: const CustomAppBar(title: 'Hotel Finder', back: true),
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [

                      quizQuestion(questionsProvider.questions[_questionIndex].questionText),

                      generateAnswers(questionsProvider.questions[_questionIndex]),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,8.0,6,8.0),
                        child: SizedBox(
                          width: 378,
                          height: 64,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[800],
                                foregroundColor: Colors.black,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              onPressed: () => {
                                if (_questionIndex == questionsProvider.questions.length - 1) {


                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ChangeNotifierProvider.value(
                                        value: context.read<QuestionProvider>(),
                                        child: HotelPage(answers: _questionAnswered),)),
                                  )
                                } else {
                                  _answerQuestion(questionsProvider.questions[_questionIndex], _answer)
                                },
                              },
                              child: _questionIndex == questionsProvider.questions.length - 1 ? const Text(
                                'Get Hotels',
                                style: TextStyle(
                                    fontSize: 27,
                                    decoration: TextDecoration.none
                                ),
                              ) : const Text(
                                'Next question',
                                style: TextStyle(
                                    fontSize: 27,
                                    decoration: TextDecoration.none
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget quizQuestion(String questionText) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      child: Text(
          questionText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }

  Widget generateAnswers(Question question) {
    if (question.name == 'facilitati') {
      if (_facilitiesAnswers.isEmpty) {
        build_list_facilities(question);
      }
      return quizFaciltiesMultipleAnswersQuestion(question);
    } else if (question.name == 'facilitati_camera') {
      if (_roomFacilitiesAnswers.isEmpty) {
        build_list_room_facilities(question);
      }
      return quizRoomFaciltiesMultipleAnswersQuestion(question);
    } else {
      return quizNormal(question);
    }
  }

  Widget quizNormal(Question question) {
    return Column(
      children: question.answers.map((answer) => Padding(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Card(
          color: Colors.amber,
          child: RadioListTile(
              title: Text(answer, style: const TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),),
              value: answer,
              groupValue: _answer,
              onChanged: ((value) {
                setState(() {
                  _answer = value!;
                });
              })
          ),
        ),
      ),
      ).toList(),
    );
  }

  Widget quizFaciltiesMultipleAnswersQuestion(Question question) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0,0,6,0),
      child: Column(
        children: List.generate(
          question.answers.length,
              (index) => Card(
            color: Colors.amber,
            child: SizedBox(
              height: 58,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0,1,0,0),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    question.answers[index],
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  value: _facilitiesAnswers[index]["value"],
                  onChanged: (value) {
                    setState(() {
                      _facilitiesAnswers[index]["value"] = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget quizRoomFaciltiesMultipleAnswersQuestion(Question question) {
    List<String> userAnswers = [];
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0,0,6.0,0),
      child: Column(
        children: List.generate(
          question.answers.length,
              (index) => Card(
                color: Colors.amber,
                child: SizedBox(
                  height: 58,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,1,0,0),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        question.answers[index],
                        style: const TextStyle(fontSize: 25.0,color: Colors.black),
                      ),
                      value: _roomFacilitiesAnswers[index]["value"],
                      checkColor: Colors.black,
                      onChanged: (value) {
                        userAnswers.add(question.answers[index]);
                        _questionAnswered.add(new Question(name: question.name, questionText: question.questionText, answers: userAnswers));
                        setState(() {
                          _roomFacilitiesAnswers[index]["value"] = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  // Widget answersText(Question question, List answersMap){
  //   List<String> userAnswers = [];
  //   String? character = question.answers[0];
  //   return Column(
  //     children: List.generate(
  //       question.answers.length,
  //           (index) => Card(
  //         color: Colors.amber,
  //         child: ListTile(
  //           title: Text(
  //             question.answers[index],
  //             style: const TextStyle(fontSize: 30.0,color: Colors.black),
  //           ),
  //           leading: Card(
  //             color: Colors.amber,
  //             child: Radio<String>(
  //               value: answersMap[index]["value"],
  //               groupValue: character,
  //               onChanged: (value) {
  //                 setState(() {
  //                   answersMap[index]["value"] = value;
  //                 });
  //               },
  //             ),
  //           ),
  //         ),
  //       ),),
  //   );
  // }

  void build_list_facilities(Question question) {
    for (String answer in question.answers) {
      _facilitiesAnswers.add(
          {
            "name": answer,
            "value": false
          }
      );
    }
  }

  void build_list_room_facilities(Question question) {
    for (String answer in question.answers) {
      _roomFacilitiesAnswers.add(
          {
            "name": answer,
            "value": false
          }
      );
    }
  }

  void _answerQuestion(Question question, String answer) {
    setState(() {
      if (question.name == 'facilitati') {
        for (int i = 0; i < _facilitiesAnswers.length; i++){
          if (_facilitiesAnswers[i]["value"] == true) {
            _questionAnswered.add(
                addAnswers(question, _facilitiesAnswers[i]["name"]));
          }
      }
      } else if (question.name == 'facilitati_camera') {
        for (int i = 0; i < _roomFacilitiesAnswers.length; i++){
          if (_roomFacilitiesAnswers[i]["value"] == true) {
            _questionAnswered.add(
                addAnswers(question, _roomFacilitiesAnswers[i]["name"]));
          }
        }
      } else {
        _questionAnswered.add(addAnswer(question, answer));
      }
      _questionIndex = _questionIndex + 1;
    });
  }
  Question addAnswers(Question question, List<String> answers) {
    return new Question(name: question.name, questionText: question.questionText, answers: answers);
  }
  Question addAnswer(Question question, String answer) {
    return new Question(name: question.name, questionText: question.questionText, answers: [answer]);
  }
}