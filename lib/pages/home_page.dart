import 'package:flutter/material.dart';
import 'package:hotel_finder/pages/questions/question_page.dart';
import 'package:hotel_finder/providers/question_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color? fundal = Colors.amber;
  @override
  Widget build(BuildContext context) {

    return SafeArea(child:
    Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/wallpaper_home.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 350, 0, 100),
          child: Card(
            color: Colors.transparent,
            child: SizedBox(
              width: 370,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,110,0),
                    child: Text(
                      'Bine ai venit!',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 39,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,10,10,20),
                    child: Text(
                      'Gaseste cazarea perfecta pentru nevoile tale raspunzand la cateva intrebari',
                      style: TextStyle(
                          color: Colors.amber[600],
                          fontSize: 24,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 340,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[800],
                        foregroundColor: Colors.black,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.0)),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: context.read<QuestionProvider>(),
                              child: QuestionPage(),
                            )
                        ))
                      },
                      child: const Text('Start',style: TextStyle(fontSize: 29, decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    )
    );
  }
}
