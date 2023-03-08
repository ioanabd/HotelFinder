import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallpaper_home.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
          child: Column(
            children: [
              Text(
                'Welcome!',
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 30,
                    decoration: TextDecoration.none
                ),
              ),
              Text(
                'Find an accomodation perfect for you by answering some simple questions',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 30,
                    decoration: TextDecoration.none
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                ),
                onPressed: startQuiz,
                child: Text(
                  'Get started',
                  style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.none
                  ),
                ),
              ),
            ],
          ),
        )
    )
    );
  }

  void startQuiz() {

  }
}