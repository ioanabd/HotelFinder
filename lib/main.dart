import 'package:flutter/material.dart';
import 'package:hotel_finder/pages/home_page.dart';
import 'package:hotel_finder/providers/question_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext ctx) => QuestionProvider())
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}