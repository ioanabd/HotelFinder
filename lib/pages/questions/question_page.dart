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
  Color _color = Colors.amber;

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
                              return Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    quizQuestion(questionsProvider.questions[index]
                                        .questionText),
                                    questionOptions(questionsProvider.questions[index]
                                        ),
                                  ],
                                ),
                              );
                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5,8.0,5,8.0),
                          child: SizedBox(
                          width: 400,
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

  Widget questionOptions(Question question) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          for ( int i = 0; i < question.answers.length; i++ )
            answersText(question, i)
        ],
      ),
    );
  }

  Widget answersText(Question question, int i){
    List<String> userAnswers = [];
    return GestureDetector(
      onTap: (){
        userAnswers.add(question.answers[i]);
        _questionAnswered.add(new Question(name: question.name, questionText: question.questionText, answers: userAnswers));
        setState(() => _color = Colors.deepPurple);
      },
      child: Card(
          color: Colors.amber[600],
          child: Container(
            width: 380,
            height: 70,
            decoration: BoxDecoration(
              color: _color
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0,20,0,0),
              child: Text(question.answers[i], style: const TextStyle(
                        fontSize: 25,
                        decoration: TextDecoration.none
                    )),
            ),
            ),
          ),
    );
  }
}
