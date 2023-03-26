import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hotel_finder/providers/question_provider.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  @override
  Widget build(BuildContext context) {
    var questionsProvider = context.watch<QuestionProvider>();
    return FutureBuilder(
        future: questionsProvider.getQuestionsFuture,
        builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.hasError) {
              return const Center(child: Text('Could not retreive recipes!'));
            }
            return ListView.builder(
                itemCount: questionsProvider.questions.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return SafeArea(
                    child: Scaffold(
                      body: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              screenHeader('Hotel Finder'),
                              quizQuestion(questionsProvider.questions[index].questionText),
                              questionOptions(questionsProvider.questions[index].answers),
                              // footerButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
  Widget screenHeader(String title) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .displaySmall,
      ),
    );
  }

    Widget quizQuestion(String questionText) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 10),
        child: Text(
          questionText,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      );
    }

  Widget questionOptions(List<String> answers) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          for ( int i = 0; i < answers.length; i++ ) Text(i.toString())
        ],
      ),
    );
  }

  Widget answersText(){
    Color? getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.amber[800];
      }
      return Colors.white;
    }
    bool isChecked = false;
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 350, 0, 100),
      child: Card(
        color: Colors.amber[800],
        child: SizedBox(
          width: 370,
          height: 80,
          child: Row(
            children: [
                Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }
              ),
                Text('alo', style: TextStyle(
                    fontSize: 27,
                    decoration: TextDecoration.none
                )),
            ],
          ),
        ),
      ),
    );
  }
}
