import 'package:flutter/material.dart';

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
              image: AssetImage('assets/images/wallpaper_home.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
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
                    padding: const EdgeInsets.fromLTRB(0,0,170,0),
                    child: Text(
                      'Welcome!',
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
                      'Find the perfect accommodation for you by answering some simple questions.',
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
                        primary: Colors.amber[800],
                        onPrimary: Colors.black,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.0)),
                      ),
                      onPressed: startQuiz,
                      child: Text(
                        'Get started',
                        style: TextStyle(
                            fontSize: 27,
                            decoration: TextDecoration.none
                        ),
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

  void startQuiz() {

  }
}