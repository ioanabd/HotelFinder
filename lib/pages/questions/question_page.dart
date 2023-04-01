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

  List _facilitiesAnswers = [];
  List _roomFacilitiesAnswers = [];

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
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: questionsProvider.questions.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (questionsProvider.questions[index].name == "facilitati") {
                              build_list_facilities(questionsProvider.questions[index]);
                              return Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    quizQuestion(questionsProvider.questions[index].questionText),
                                    quizFaciltiesMultipleAnswersQuestion(questionsProvider.questions[index])
                                  ],
                                ),
                              );
                            } else if (questionsProvider.questions[index].name == "facilitati_camera") {
                              build_list_room_facilities(questionsProvider.questions[index]);
                              return Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    quizQuestion(questionsProvider.questions[index].questionText),
                                    quizRoomFaciltiesMultipleAnswersQuestion(questionsProvider.questions[index])
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    quizQuestion(questionsProvider.questions[index]
                                        .questionText),
                                    answersText(questionsProvider.questions[index]
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                      ),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider.value(
                                    value: context.read<QuestionProvider>(),
                                    child: HotelPage(answers: _questionAnswered),)),
                              ),},
                            child: const Text(
                              'Get Hotels',
                              style: TextStyle(
                                  fontSize: 27,
                                  decoration: TextDecoration.none
                              ),
                            ),
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

  Widget quizFaciltiesMultipleAnswersQuestion(Question question) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0,0,6,0),
      child: Column(
        children: List.generate(
          question.answers.length,
              (index) => Card(
                color: Colors.amber,
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
    );
  }

  Widget answersText(Question question){
    List<String> userAnswers = [];
    String? _character = question.answers[0];
    return Column(
      children: List.generate(
          question.answers.length,
              (index) => Card(
              color: Colors.amber,
                child: ListTile(
                  title: Text(
                    question.answers[index],
                    style: const TextStyle(fontSize: 25.0,color: Colors.black),
                  ),
                  leading: Radio<String>(
                    value: question.answers[0],
                    groupValue: _character,
                    onChanged: (String? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
      ),),
    );
  }

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

  // void answers_single(Question question){
  //   _singleAnswer.add(
  //       {
  //         "name": question,
  //         "value": false
  //       }
  //   );
  // }
}